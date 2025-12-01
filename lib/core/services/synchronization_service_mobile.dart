import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:encrypt/encrypt.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/database/database.dart';

class SynchronizationServiceMobile {
  final AppDatabase db;
  SynchronizationServiceMobile(this.db);
  WebSocket? _ws;
  bool _receivingTables = false;
  Map<String, List<Map<String, dynamic>>> _receivedTables = {};

  bool get isConnected => _ws != null;
  String? lastMessage;
  void Function(Map<String, dynamic>)? onMessage;

  bool _deleteMissingEntry = false;
  Key _key = Key.fromSecureRandom(1);

  Future<void> connect(String ip, int port, String key) async {
    final url = "ws://$ip:$port";
    _ws = await WebSocket.connect(url);
    _ws!.add(jsonEncode({"type": "handshake", "key": key}));
    _key = Key(base64Url.decode(key));

    _ws!.listen(
      (msg) => _handleMessage(msg),
      onDone: () {
        _ws = null;
      },
      onError: (_) => _ws = null,
    );
  }

  Future<void> disconnect() async {
    await _ws?.close();
    _ws = null;
  }

  void send(String data) {
    _ws?.add(data);
  }

  void _handleMessage(dynamic msg) async {
    final data = decryptPayload(msg, _key);
    final type = data['type'];

    switch (type) {
      case 'request_sync':
        await _sendTables();
        break;

      case 'sync_start':
        _deleteMissingEntry = false;
        _receivingTables = true;
        _receivedTables = {};
        break;

      case 'table_data':
        if (!_receivingTables) return;
        _deleteMissingEntry = data['deleteMissingEntry'];
        final tableName = data['tableName'] as String;
        final rows = List<Map<String, dynamic>>.from(data['rows'] ?? []);
        _receivedTables[tableName] = rows;
        break;

      case 'sync_complete':
        await _applyReceivedTables();
        _receivingTables = false;
        _notify(data);
        break;
    }

    _notify(data);
  }

  void _notify(Map<String, dynamic> msg) {
    if (onMessage != null) onMessage!(msg);
  }

  String encryptPayload(Map<String, dynamic> payload, Key key) {
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final iv = IV.fromSecureRandom(12);

    final plainText = jsonEncode(payload);
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    final combined = base64Url.encode(iv.bytes + encrypted.bytes);
    return combined;
  }

  Map<String, dynamic> decryptPayload(String encryptedData, Key key) {
    final bytes = base64Url.decode(encryptedData);

    final iv = IV(bytes.sublist(0, 12));
    final cipherText = bytes.sublist(12);

    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final decrypted = encrypter.decrypt(Encrypted(cipherText), iv: iv);

    return jsonDecode(decrypted);
  }

  // ------------- DB ACTIONS ------------------- \\
  Future<void> _sendTables() async {
    if (_ws == null) return;

    final tables = <String, List<Map<String, dynamic>>>{};

    tables['users'] = (await db.select(db.users).get())
        .map((u) => u.toJson())
        .toList();

    tables['transaction_labels'] = (await db.select(db.transactionLabels).get())
        .map((t) => t.toJson())
        .toList();

    tables['categories'] = (await db.select(db.categories).get())
        .map((c) => c.toJson())
        .toList();

    tables['topics'] = (await db.select(db.topics).get())
        .map((t) => t.toJson())
        .toList();

    tables['fix_transactions'] = (await db.select(db.fixTransactions).get())
        .map((f) => f.toJson())
        .toList();

    tables['var_transactions'] = (await db.select(db.varTransactions).get())
        .map((v) => v.toJson())
        .toList();

    final tableNames = tables.keys.toList();
    final total = tableNames.length;
    send(encryptPayload({'type': 'sync_start', 'tableCount': total}, _key));

    for (var i = 0; i < total; i++) {
      final name = tableNames[i];
      final rows = tables[name]!;

      send(
        encryptPayload({
          'type': 'table_data',
          'tableName': name,
          'rows': rows,
          'tableIndex': i,
          'tableCount': total,
        }, _key),
      );
      _notify({'type': 'table_data', 'tableIndex': i, 'tableCount': total});
    }

    send(encryptPayload({'type': 'sync_complete', 'success': true}, _key));
    _notify({'type': 'sync_complete', 'success': true});
  }

  Future<void> _applyReceivedTables() async {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
      if (v is String) {
        try {
          return DateTime.parse(v);
        } catch (_) {
          final asInt = int.tryParse(v);
          if (asInt != null) return DateTime.fromMillisecondsSinceEpoch(asInt);
        }
      }
      return null;
    }

    // Begin DB transaction to keep integrity
    await db.transaction(() async {
      final Map<int, int> fixTransactionRefTable = {};
      for (final entry in _receivedTables.entries) {
        final tableName = entry.key;
        final rows = entry.value;

        switch (tableName) {
          case 'users':
          case 'Users':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              await (db.delete(db.users)..where((u) => u.id.isNotIn(ids))).go();
            }
            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.users,
              )..where((u) => u.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                final companion = UsersCompanion(
                  id: Value(idValue),
                  name: Value(row['name'] as String),
                  color: Value(row['color'] as String),
                  lastEdit: Value(incomingLastEdit),
                );
                await db.into(db.users).insert(companion);
              } else {
                if (incomingLastEdit.isAfter(existing.lastEdit)) {
                  final companion = UsersCompanion(
                    name: Value(row['name'] as String),
                    color: Value(row['color'] as String),
                    lastEdit: Value(incomingLastEdit),
                  );
                  await (db.update(
                    db.users,
                  )..where((u) => u.id.equals(idValue))).write(companion);
                }
              }
            }
            break;

          case 'transaction_labels':
          case 'TransactionLabels':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              await (db.delete(
                db.transactionLabels,
              )..where((t) => t.id.isNotIn(ids))).go();
            }
            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.transactionLabels,
              )..where((t) => t.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                final companion = TransactionLabelsCompanion(
                  id: Value(idValue),
                  name: Value(row['name'] as String),
                  color: Value(row['color'] as String),
                  lastEdit: Value(incomingLastEdit),
                );
                await db.into(db.transactionLabels).insert(companion);
              } else {
                if (incomingLastEdit.isAfter(existing.lastEdit)) {
                  final companion = TransactionLabelsCompanion(
                    name: Value(row['name'] as String),
                    color: Value(row['color'] as String),
                    lastEdit: Value(incomingLastEdit),
                  );
                  await (db.update(
                    db.transactionLabels,
                  )..where((t) => t.id.equals(idValue))).write(companion);
                }
              }
            }
            break;

          case 'categories':
          case 'Categories':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              final categoriesToDelete = await (db.select(
                db.categories,
              )..where((c) => c.id.isNotIn(ids))).get();

              for (final cat in categoriesToDelete) {
                final categoryId = cat.id;

                final topics = await (db.select(
                  db.topics,
                )..where((t) => t.categoryId.equals(categoryId))).get();

                final topicIds = topics.map((t) => t.id).toList();

                if (topicIds.isNotEmpty) {
                  final varTransactions = await (db.select(
                    db.varTransactions,
                  )..where((v) => v.topicId.isIn(topicIds))).get();

                  for (final vt in varTransactions) {
                    if (vt.compensations != null) {
                      final compensations = JsonUtil.string2CompensationInfo(
                        vt.compensations!,
                      )!;
                      for (final compId in compensations.keys) {
                        await (db.delete(
                          db.varTransactions,
                        )..where((vT) => vT.id.equals(compId))).go();
                      }
                    }

                    if (vt.varRefId != null) {
                      final parent =
                          await (db.select(db.varTransactions)
                                ..where((v) => v.id.equals(vt.varRefId!)))
                              .getSingleOrNull();

                      if (parent != null && parent.compensations != null) {
                        final parentComps = JsonUtil.string2CompensationInfo(
                          parent.compensations!,
                        )!;
                        parentComps.remove(vt.id);

                        await (db.update(
                          db.varTransactions,
                        )..where((v) => v.id.equals(parent.id))).write(
                          VarTransactionsCompanion(
                            compensations: Value(
                              parentComps.isEmpty
                                  ? null
                                  : JsonUtil.compensation2String(parentComps),
                            ),
                          ),
                        );
                      }
                    }

                    await (db.delete(
                      db.varTransactions,
                    )..where((v) => v.topicId.isIn(topicIds))).go();
                  }

                  await (db.delete(
                    db.topics,
                  )..where((t) => t.categoryId.equals(categoryId))).go();

                  await (db.delete(
                    db.categories,
                  )..where((c) => c.id.equals(categoryId))).go();
                }
              }
            }

            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.categories,
              )..where((c) => c.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                final companion = CategoriesCompanion(
                  id: Value(idValue),
                  name: Value(row['name'] as String),
                  description: Value(row['description'] as String?),
                  lastEdit: Value(incomingLastEdit),
                );
                await db.into(db.categories).insert(companion);
              } else {
                if (incomingLastEdit.isAfter(existing.lastEdit)) {
                  final companion = CategoriesCompanion(
                    name: Value(row['name'] as String),
                    description: Value(row['description'] as String?),
                    lastEdit: Value(incomingLastEdit),
                  );
                  await (db.update(
                    db.categories,
                  )..where((c) => c.id.equals(idValue))).write(companion);
                }
              }
            }
            break;

          case 'topics':
          case 'Topics':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              final topicsToDelete = await (db.select(
                db.topics,
              )..where((t) => t.id.isNotIn(ids))).get();

              for (final topic in topicsToDelete) {
                final topicId = topic.id;

                final varTransactions = await (db.select(
                  db.varTransactions,
                )..where((v) => v.topicId.equals(topicId))).get();

                for (final vt in varTransactions) {
                  if (vt.compensations != null) {
                    final comps = JsonUtil.string2CompensationInfo(
                      vt.compensations!,
                    )!;
                    for (final cId in comps.keys) {
                      await (db.delete(
                        db.varTransactions,
                      )..where((v) => v.id.equals(cId))).go();
                    }
                  }

                  if (vt.varRefId != null) {
                    final parent =
                        await (db.select(db.varTransactions)
                              ..where((v) => v.id.equals(vt.varRefId!)))
                            .getSingleOrNull();

                    if (parent != null && parent.compensations != null) {
                      final parentComps = JsonUtil.string2CompensationInfo(
                        parent.compensations!,
                      )!;
                      parentComps.remove(vt.id);

                      await (db.update(
                        db.varTransactions,
                      )..where((v) => v.id.equals(parent.id))).write(
                        VarTransactionsCompanion(
                          compensations: Value(
                            parentComps.isEmpty
                                ? null
                                : JsonUtil.compensation2String(parentComps),
                          ),
                        ),
                      );
                    }
                  }
                }

                await (db.delete(
                  db.varTransactions,
                )..where((v) => v.topicId.equals(topicId))).go();

                await (db.delete(
                  db.topics,
                )..where((t) => t.id.equals(topicId))).go();
              }
            }
            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.topics,
              )..where((t) => t.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                final companion = TopicsCompanion(
                  id: Value(idValue),
                  categoryId: Value(row['categoryId'] as int),
                  name: Value(row['name'] as String),
                  description: Value(row['description'] as String?),
                  lastEdit: Value(incomingLastEdit),
                );
                await db.into(db.topics).insert(companion);
              } else if (incomingLastEdit.isAfter(existing.lastEdit)) {
                final companion = TopicsCompanion(
                  categoryId: Value(row['categoryId'] as int),
                  name: Value(row['name'] as String),
                  description: Value(row['description'] as String?),
                  lastEdit: Value(incomingLastEdit),
                );
                await (db.update(
                  db.topics,
                )..where((t) => t.id.equals(idValue))).write(companion);
              }
            }
            break;

          case 'fix_transactions':
          case 'FixTransactions':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              await (db.update(db.varTransactions)..where(
                    (v) => v.fixRefId.isNotNull() & v.fixRefId.isNotIn(ids),
                  ))
                  .write(VarTransactionsCompanion(fixRefId: Value.absent()));
              await (db.delete(
                db.fixTransactions,
              )..where((f) => f.id.isNotIn(ids))).go();
            }
            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.fixTransactions,
              )..where((t) => t.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                fixTransactionRefTable[idValue] = row['varRefId'];
                final companion = FixTransactionsCompanion(
                  id: Value(idValue),
                  topicId: Value(row['topicId'] as int),
                  status: Value(Status.values.byName(row['status'])),
                  start: Value(parseDate((row['start']))!),
                  end: Value(parseDate((row['end']))!),
                  intervalCount: Value(row['intervalCount'] as int),
                  intervalUnit: Value(
                    IntervalUnit.values.byName(row['intervalUnit']),
                  ),
                  value: Value(row['value'] as int),
                  userRefId: Value(row['userRefId'] as int),
                  lastEdit: Value(incomingLastEdit),
                  compensations: Value(row['compensations'] as String?),
                  transactionLabelId: Value(row['transactionLabelId'] as int?),
                  description: Value(row['description'] as String?),
                  latestDate: Value(parseDate((row['latestDate']))!),
                  varRefId: Value.absent(),
                  fileRefId: Value(row['fileRefId'] as int?),
                );
                await db.into(db.fixTransactions).insert(companion);
              } else if (incomingLastEdit.isAfter(existing.lastEdit)) {
                final companion = FixTransactionsCompanion(
                  topicId: Value(row['topicId'] as int),
                  status: Value(Status.values.byName(row['status'])),
                  start: Value(parseDate((row['start']))!),
                  end: Value(parseDate((row['end']))!),
                  intervalCount: Value(row['intervalCount'] as int),
                  intervalUnit: Value(
                    IntervalUnit.values.byName(row['status']),
                  ),
                  value: Value(row['value'] as int),
                  userRefId: Value(row['userRefId'] as int),
                  lastEdit: Value(incomingLastEdit),
                  compensations: Value(row['compensations'] as String?),
                  transactionLabelId: Value(row['transactionLabelId'] as int?),
                  description: Value(row['description'] as String?),
                  latestDate: Value(parseDate((row['latestDate']))!),
                  varRefId: Value(row['varRefId'] as int?),
                  fileRefId: Value(row['fileRefId'] as int?),
                );
                await (db.update(
                  db.fixTransactions,
                )..where((t) => t.id.equals(idValue))).write(companion);
              }
            }
            break;

          case 'var_transactions':
          case 'VarTransactions':
            if (_deleteMissingEntry == true) {
              final ids = rows.map((e) => e['id'] as int).toList();
              final toBeDeleted =
                  await (db.select(db.varTransactions)..where(
                        (v) =>
                            v.id.isNotIn(ids) &
                            v.varRefId.isNotNull() &
                            v.varRefId.isIn(ids),
                      ))
                      .get();
              for (final entry in toBeDeleted) {
                final parent =
                    await (db.select(db.varTransactions)
                          ..where((v) => v.id.equals(entry.varRefId!)))
                        .getSingleOrNull();
                if (parent != null && parent.compensations != null) {
                  final parentComps = JsonUtil.string2CompensationInfo(
                    parent.compensations,
                  )!;
                  parentComps.remove(entry.id);
                  final updatedComps = parentComps.isEmpty ? null : parentComps;
                  await (db.update(
                    db.varTransactions,
                  )..where((v) => v.id.equals(parent.id))).write(
                    VarTransactionsCompanion(
                      compensations: Value(
                        JsonUtil.compensation2String(updatedComps),
                      ),
                    ),
                  );
                }
              }
              await (db.delete(
                db.varTransactions,
              )..where((v) => v.id.isNotIn(ids))).go();
            }
            for (final row in rows) {
              final idValue = row['id'] as int;
              final incomingLastEdit = parseDate((row['lastEdit']))!;

              final existing = await (db.select(
                db.varTransactions,
              )..where((t) => t.id.equals(idValue))).getSingleOrNull();

              if (existing == null) {
                final companion = VarTransactionsCompanion(
                  id: Value(idValue),
                  topicId: Value(row['topicId'] as int),
                  date: Value(parseDate((row['date']))!),
                  value: Value(row['value'] as int),
                  userRefId: Value(row['userRefId'] as int),
                  lastEdit: Value(incomingLastEdit),
                  compensations: Value(row['compensations'] as String?),
                  transactionLabelId: Value(row['transactionLabelId'] as int?),
                  description: Value(row['description'] as String?),
                  fixRefId: Value(row['fixRefId'] as int?),
                  varRefId: Value(row['varRefId'] as int?),
                  fileRefId: Value(row['fileRefId'] as int?),
                );
                await db.into(db.varTransactions).insert(companion);
              } else if (incomingLastEdit.isAfter(existing.lastEdit)) {
                final companion = VarTransactionsCompanion(
                  topicId: Value(row['topicId'] as int),
                  date: Value(parseDate((row['date']))!),
                  value: Value(row['value'] as int),
                  userRefId: Value(row['userRefId'] as int),
                  lastEdit: Value(incomingLastEdit),
                  compensations: Value(row['compensations'] as String?),
                  transactionLabelId: Value(row['transactionLabelId'] as int?),
                  description: Value(row['description'] as String?),
                  fixRefId: Value(row['fixRefId'] as int?),
                  varRefId: Value(row['varRefId'] as int?),
                  fileRefId: Value(row['fileRefId'] as int?),
                );
                await (db.update(
                  db.varTransactions,
                )..where((t) => t.id.equals(idValue))).write(companion);
              }
            }
            break;
        }
      }
      for (final e in fixTransactionRefTable.entries) {
        await (db.update(db.fixTransactions)..where((f) => f.id.equals(e.key)))
            .write(FixTransactionsCompanion(varRefId: Value(e.value)));
      }
    });

    _deleteMissingEntry = false;
    _receivedTables.clear();
    _receivingTables = false;

    _notify({'type': 'sync_complete', 'success': true});
  }
}
