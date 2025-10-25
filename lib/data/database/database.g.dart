// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String? description;
  const Category({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, Topic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Topic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Topic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Topic(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class Topic extends DataClass implements Insertable<Topic> {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  const Topic({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Topic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Topic(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Topic copyWith({
    int? id,
    int? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => Topic(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  Topic copyWithCompanion(TopicsCompanion data) {
    return Topic(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Topic(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Topic &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description);
}

class TopicsCompanion extends UpdateCompanion<Topic> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<String?> description;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  TopicsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    this.description = const Value.absent(),
  }) : categoryId = Value(categoryId),
       name = Value(name);
  static Insertable<Topic> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  TopicsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<String?>? description,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $FixTransactionsTable extends FixTransactions
    with TableInfo<$FixTransactionsTable, FixTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FixTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Status, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Status>($FixTransactionsTable.$converterstatus);
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalCountMeta = const VerificationMeta(
    'intervalCount',
  );
  @override
  late final GeneratedColumn<int> intervalCount = GeneratedColumn<int>(
    'interval_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<IntervalUnit, String>
  intervalUnit = GeneratedColumn<String>(
    'interval_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<IntervalUnit>($FixTransactionsTable.$converterintervalUnit);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _compensationsMeta = const VerificationMeta(
    'compensations',
  );
  @override
  late final GeneratedColumn<String> compensations = GeneratedColumn<String>(
    'compensations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decriptionMeta = const VerificationMeta(
    'decription',
  );
  @override
  late final GeneratedColumn<String> decription = GeneratedColumn<String>(
    'decription',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    compensations,
    decription,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fix_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FixTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    } else if (isInserting) {
      context.missing(_endMeta);
    }
    if (data.containsKey('interval_count')) {
      context.handle(
        _intervalCountMeta,
        intervalCount.isAcceptableOrUnknown(
          data['interval_count']!,
          _intervalCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalCountMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('compensations')) {
      context.handle(
        _compensationsMeta,
        compensations.isAcceptableOrUnknown(
          data['compensations']!,
          _compensationsMeta,
        ),
      );
    }
    if (data.containsKey('decription')) {
      context.handle(
        _decriptionMeta,
        decription.isAcceptableOrUnknown(data['decription']!, _decriptionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FixTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FixTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      status: $FixTransactionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      )!,
      intervalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_count'],
      )!,
      intervalUnit: $FixTransactionsTable.$converterintervalUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}interval_unit'],
        )!,
      ),
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      compensations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compensations'],
      ),
      decription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decription'],
      ),
    );
  }

  @override
  $FixTransactionsTable createAlias(String alias) {
    return $FixTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, String, String> $converterstatus =
      const EnumNameConverter<Status>(Status.values);
  static JsonTypeConverter2<IntervalUnit, String, String>
  $converterintervalUnit = const EnumNameConverter<IntervalUnit>(
    IntervalUnit.values,
  );
}

class FixTransaction extends DataClass implements Insertable<FixTransaction> {
  final int id;
  final int topicId;
  final Status status;
  final DateTime start;
  final DateTime end;
  final int intervalCount;
  final IntervalUnit intervalUnit;
  final int value;
  final String? compensations;
  final String? decription;
  const FixTransaction({
    required this.id,
    required this.topicId,
    required this.status,
    required this.start,
    required this.end,
    required this.intervalCount,
    required this.intervalUnit,
    required this.value,
    this.compensations,
    this.decription,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    {
      map['status'] = Variable<String>(
        $FixTransactionsTable.$converterstatus.toSql(status),
      );
    }
    map['start'] = Variable<DateTime>(start);
    map['end'] = Variable<DateTime>(end);
    map['interval_count'] = Variable<int>(intervalCount);
    {
      map['interval_unit'] = Variable<String>(
        $FixTransactionsTable.$converterintervalUnit.toSql(intervalUnit),
      );
    }
    map['value'] = Variable<int>(value);
    if (!nullToAbsent || compensations != null) {
      map['compensations'] = Variable<String>(compensations);
    }
    if (!nullToAbsent || decription != null) {
      map['decription'] = Variable<String>(decription);
    }
    return map;
  }

  FixTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FixTransactionsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      status: Value(status),
      start: Value(start),
      end: Value(end),
      intervalCount: Value(intervalCount),
      intervalUnit: Value(intervalUnit),
      value: Value(value),
      compensations: compensations == null && nullToAbsent
          ? const Value.absent()
          : Value(compensations),
      decription: decription == null && nullToAbsent
          ? const Value.absent()
          : Value(decription),
    );
  }

  factory FixTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FixTransaction(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      status: $FixTransactionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime>(json['end']),
      intervalCount: serializer.fromJson<int>(json['intervalCount']),
      intervalUnit: $FixTransactionsTable.$converterintervalUnit.fromJson(
        serializer.fromJson<String>(json['intervalUnit']),
      ),
      value: serializer.fromJson<int>(json['value']),
      compensations: serializer.fromJson<String?>(json['compensations']),
      decription: serializer.fromJson<String?>(json['decription']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'status': serializer.toJson<String>(
        $FixTransactionsTable.$converterstatus.toJson(status),
      ),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime>(end),
      'intervalCount': serializer.toJson<int>(intervalCount),
      'intervalUnit': serializer.toJson<String>(
        $FixTransactionsTable.$converterintervalUnit.toJson(intervalUnit),
      ),
      'value': serializer.toJson<int>(value),
      'compensations': serializer.toJson<String?>(compensations),
      'decription': serializer.toJson<String?>(decription),
    };
  }

  FixTransaction copyWith({
    int? id,
    int? topicId,
    Status? status,
    DateTime? start,
    DateTime? end,
    int? intervalCount,
    IntervalUnit? intervalUnit,
    int? value,
    Value<String?> compensations = const Value.absent(),
    Value<String?> decription = const Value.absent(),
  }) => FixTransaction(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    status: status ?? this.status,
    start: start ?? this.start,
    end: end ?? this.end,
    intervalCount: intervalCount ?? this.intervalCount,
    intervalUnit: intervalUnit ?? this.intervalUnit,
    value: value ?? this.value,
    compensations: compensations.present
        ? compensations.value
        : this.compensations,
    decription: decription.present ? decription.value : this.decription,
  );
  FixTransaction copyWithCompanion(FixTransactionsCompanion data) {
    return FixTransaction(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      status: data.status.present ? data.status.value : this.status,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      intervalCount: data.intervalCount.present
          ? data.intervalCount.value
          : this.intervalCount,
      intervalUnit: data.intervalUnit.present
          ? data.intervalUnit.value
          : this.intervalUnit,
      value: data.value.present ? data.value.value : this.value,
      compensations: data.compensations.present
          ? data.compensations.value
          : this.compensations,
      decription: data.decription.present
          ? data.decription.value
          : this.decription,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FixTransaction(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('status: $status, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('intervalUnit: $intervalUnit, ')
          ..write('value: $value, ')
          ..write('compensations: $compensations, ')
          ..write('decription: $decription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    compensations,
    decription,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FixTransaction &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.status == this.status &&
          other.start == this.start &&
          other.end == this.end &&
          other.intervalCount == this.intervalCount &&
          other.intervalUnit == this.intervalUnit &&
          other.value == this.value &&
          other.compensations == this.compensations &&
          other.decription == this.decription);
}

class FixTransactionsCompanion extends UpdateCompanion<FixTransaction> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<Status> status;
  final Value<DateTime> start;
  final Value<DateTime> end;
  final Value<int> intervalCount;
  final Value<IntervalUnit> intervalUnit;
  final Value<int> value;
  final Value<String?> compensations;
  final Value<String?> decription;
  const FixTransactionsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.status = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.intervalCount = const Value.absent(),
    this.intervalUnit = const Value.absent(),
    this.value = const Value.absent(),
    this.compensations = const Value.absent(),
    this.decription = const Value.absent(),
  });
  FixTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required Status status,
    required DateTime start,
    required DateTime end,
    required int intervalCount,
    required IntervalUnit intervalUnit,
    required int value,
    this.compensations = const Value.absent(),
    this.decription = const Value.absent(),
  }) : topicId = Value(topicId),
       status = Value(status),
       start = Value(start),
       end = Value(end),
       intervalCount = Value(intervalCount),
       intervalUnit = Value(intervalUnit),
       value = Value(value);
  static Insertable<FixTransaction> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<String>? status,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? intervalCount,
    Expression<String>? intervalUnit,
    Expression<int>? value,
    Expression<String>? compensations,
    Expression<String>? decription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (status != null) 'status': status,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (intervalCount != null) 'interval_count': intervalCount,
      if (intervalUnit != null) 'interval_unit': intervalUnit,
      if (value != null) 'value': value,
      if (compensations != null) 'compensations': compensations,
      if (decription != null) 'decription': decription,
    });
  }

  FixTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<Status>? status,
    Value<DateTime>? start,
    Value<DateTime>? end,
    Value<int>? intervalCount,
    Value<IntervalUnit>? intervalUnit,
    Value<int>? value,
    Value<String?>? compensations,
    Value<String?>? decription,
  }) {
    return FixTransactionsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      status: status ?? this.status,
      start: start ?? this.start,
      end: end ?? this.end,
      intervalCount: intervalCount ?? this.intervalCount,
      intervalUnit: intervalUnit ?? this.intervalUnit,
      value: value ?? this.value,
      compensations: compensations ?? this.compensations,
      decription: decription ?? this.decription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $FixTransactionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (intervalCount.present) {
      map['interval_count'] = Variable<int>(intervalCount.value);
    }
    if (intervalUnit.present) {
      map['interval_unit'] = Variable<String>(
        $FixTransactionsTable.$converterintervalUnit.toSql(intervalUnit.value),
      );
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (compensations.present) {
      map['compensations'] = Variable<String>(compensations.value);
    }
    if (decription.present) {
      map['decription'] = Variable<String>(decription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FixTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('status: $status, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('intervalCount: $intervalCount, ')
          ..write('intervalUnit: $intervalUnit, ')
          ..write('value: $value, ')
          ..write('compensations: $compensations, ')
          ..write('decription: $decription')
          ..write(')'))
        .toString();
  }
}

class $VarTransactionsTable extends VarTransactions
    with TableInfo<$VarTransactionsTable, VarTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VarTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<int> topicId = GeneratedColumn<int>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _compensationsMeta = const VerificationMeta(
    'compensations',
  );
  @override
  late final GeneratedColumn<String> compensations = GeneratedColumn<String>(
    'compensations',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decriptionMeta = const VerificationMeta(
    'decription',
  );
  @override
  late final GeneratedColumn<String> decription = GeneratedColumn<String>(
    'decription',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fixRefIdMeta = const VerificationMeta(
    'fixRefId',
  );
  @override
  late final GeneratedColumn<int> fixRefId = GeneratedColumn<int>(
    'fix_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varRefIdMeta = const VerificationMeta(
    'varRefId',
  );
  @override
  late final GeneratedColumn<int> varRefId = GeneratedColumn<int>(
    'var_ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topicId,
    date,
    value,
    compensations,
    decription,
    fixRefId,
    varRefId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'var_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<VarTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('compensations')) {
      context.handle(
        _compensationsMeta,
        compensations.isAcceptableOrUnknown(
          data['compensations']!,
          _compensationsMeta,
        ),
      );
    }
    if (data.containsKey('decription')) {
      context.handle(
        _decriptionMeta,
        decription.isAcceptableOrUnknown(data['decription']!, _decriptionMeta),
      );
    }
    if (data.containsKey('fix_ref_id')) {
      context.handle(
        _fixRefIdMeta,
        fixRefId.isAcceptableOrUnknown(data['fix_ref_id']!, _fixRefIdMeta),
      );
    }
    if (data.containsKey('var_ref_id')) {
      context.handle(
        _varRefIdMeta,
        varRefId.isAcceptableOrUnknown(data['var_ref_id']!, _varRefIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VarTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VarTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}topic_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      )!,
      compensations: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compensations'],
      ),
      decription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decription'],
      ),
      fixRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fix_ref_id'],
      ),
      varRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}var_ref_id'],
      ),
    );
  }

  @override
  $VarTransactionsTable createAlias(String alias) {
    return $VarTransactionsTable(attachedDatabase, alias);
  }
}

class VarTransaction extends DataClass implements Insertable<VarTransaction> {
  final int id;
  final int topicId;
  final DateTime date;
  final int value;
  final String? compensations;
  final String? decription;
  final int? fixRefId;
  final int? varRefId;
  const VarTransaction({
    required this.id,
    required this.topicId,
    required this.date,
    required this.value,
    this.compensations,
    this.decription,
    this.fixRefId,
    this.varRefId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<int>(topicId);
    map['date'] = Variable<DateTime>(date);
    map['value'] = Variable<int>(value);
    if (!nullToAbsent || compensations != null) {
      map['compensations'] = Variable<String>(compensations);
    }
    if (!nullToAbsent || decription != null) {
      map['decription'] = Variable<String>(decription);
    }
    if (!nullToAbsent || fixRefId != null) {
      map['fix_ref_id'] = Variable<int>(fixRefId);
    }
    if (!nullToAbsent || varRefId != null) {
      map['var_ref_id'] = Variable<int>(varRefId);
    }
    return map;
  }

  VarTransactionsCompanion toCompanion(bool nullToAbsent) {
    return VarTransactionsCompanion(
      id: Value(id),
      topicId: Value(topicId),
      date: Value(date),
      value: Value(value),
      compensations: compensations == null && nullToAbsent
          ? const Value.absent()
          : Value(compensations),
      decription: decription == null && nullToAbsent
          ? const Value.absent()
          : Value(decription),
      fixRefId: fixRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(fixRefId),
      varRefId: varRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(varRefId),
    );
  }

  factory VarTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VarTransaction(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<int>(json['topicId']),
      date: serializer.fromJson<DateTime>(json['date']),
      value: serializer.fromJson<int>(json['value']),
      compensations: serializer.fromJson<String?>(json['compensations']),
      decription: serializer.fromJson<String?>(json['decription']),
      fixRefId: serializer.fromJson<int?>(json['fixRefId']),
      varRefId: serializer.fromJson<int?>(json['varRefId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<int>(topicId),
      'date': serializer.toJson<DateTime>(date),
      'value': serializer.toJson<int>(value),
      'compensations': serializer.toJson<String?>(compensations),
      'decription': serializer.toJson<String?>(decription),
      'fixRefId': serializer.toJson<int?>(fixRefId),
      'varRefId': serializer.toJson<int?>(varRefId),
    };
  }

  VarTransaction copyWith({
    int? id,
    int? topicId,
    DateTime? date,
    int? value,
    Value<String?> compensations = const Value.absent(),
    Value<String?> decription = const Value.absent(),
    Value<int?> fixRefId = const Value.absent(),
    Value<int?> varRefId = const Value.absent(),
  }) => VarTransaction(
    id: id ?? this.id,
    topicId: topicId ?? this.topicId,
    date: date ?? this.date,
    value: value ?? this.value,
    compensations: compensations.present
        ? compensations.value
        : this.compensations,
    decription: decription.present ? decription.value : this.decription,
    fixRefId: fixRefId.present ? fixRefId.value : this.fixRefId,
    varRefId: varRefId.present ? varRefId.value : this.varRefId,
  );
  VarTransaction copyWithCompanion(VarTransactionsCompanion data) {
    return VarTransaction(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      date: data.date.present ? data.date.value : this.date,
      value: data.value.present ? data.value.value : this.value,
      compensations: data.compensations.present
          ? data.compensations.value
          : this.compensations,
      decription: data.decription.present
          ? data.decription.value
          : this.decription,
      fixRefId: data.fixRefId.present ? data.fixRefId.value : this.fixRefId,
      varRefId: data.varRefId.present ? data.varRefId.value : this.varRefId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VarTransaction(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('compensations: $compensations, ')
          ..write('decription: $decription, ')
          ..write('fixRefId: $fixRefId, ')
          ..write('varRefId: $varRefId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topicId,
    date,
    value,
    compensations,
    decription,
    fixRefId,
    varRefId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VarTransaction &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.date == this.date &&
          other.value == this.value &&
          other.compensations == this.compensations &&
          other.decription == this.decription &&
          other.fixRefId == this.fixRefId &&
          other.varRefId == this.varRefId);
}

class VarTransactionsCompanion extends UpdateCompanion<VarTransaction> {
  final Value<int> id;
  final Value<int> topicId;
  final Value<DateTime> date;
  final Value<int> value;
  final Value<String?> compensations;
  final Value<String?> decription;
  final Value<int?> fixRefId;
  final Value<int?> varRefId;
  const VarTransactionsCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.date = const Value.absent(),
    this.value = const Value.absent(),
    this.compensations = const Value.absent(),
    this.decription = const Value.absent(),
    this.fixRefId = const Value.absent(),
    this.varRefId = const Value.absent(),
  });
  VarTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int topicId,
    required DateTime date,
    required int value,
    this.compensations = const Value.absent(),
    this.decription = const Value.absent(),
    this.fixRefId = const Value.absent(),
    this.varRefId = const Value.absent(),
  }) : topicId = Value(topicId),
       date = Value(date),
       value = Value(value);
  static Insertable<VarTransaction> custom({
    Expression<int>? id,
    Expression<int>? topicId,
    Expression<DateTime>? date,
    Expression<int>? value,
    Expression<String>? compensations,
    Expression<String>? decription,
    Expression<int>? fixRefId,
    Expression<int>? varRefId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (date != null) 'date': date,
      if (value != null) 'value': value,
      if (compensations != null) 'compensations': compensations,
      if (decription != null) 'decription': decription,
      if (fixRefId != null) 'fix_ref_id': fixRefId,
      if (varRefId != null) 'var_ref_id': varRefId,
    });
  }

  VarTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? topicId,
    Value<DateTime>? date,
    Value<int>? value,
    Value<String?>? compensations,
    Value<String?>? decription,
    Value<int?>? fixRefId,
    Value<int?>? varRefId,
  }) {
    return VarTransactionsCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      date: date ?? this.date,
      value: value ?? this.value,
      compensations: compensations ?? this.compensations,
      decription: decription ?? this.decription,
      fixRefId: fixRefId ?? this.fixRefId,
      varRefId: varRefId ?? this.varRefId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<int>(topicId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (compensations.present) {
      map['compensations'] = Variable<String>(compensations.value);
    }
    if (decription.present) {
      map['decription'] = Variable<String>(decription.value);
    }
    if (fixRefId.present) {
      map['fix_ref_id'] = Variable<int>(fixRefId.value);
    }
    if (varRefId.present) {
      map['var_ref_id'] = Variable<int>(varRefId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VarTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('compensations: $compensations, ')
          ..write('decription: $decription, ')
          ..write('fixRefId: $fixRefId, ')
          ..write('varRefId: $varRefId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $FixTransactionsTable fixTransactions = $FixTransactionsTable(
    this,
  );
  late final $VarTransactionsTable varTransactions = $VarTransactionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    topics,
    fixTransactions,
    varTransactions,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TopicsTable, List<Topic>> _topicsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.topics,
    aliasName: $_aliasNameGenerator(db.categories.id, db.topics.categoryId),
  );

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicsRefs(
    Expression<bool> Function($$TopicsTableFilterComposer f) f,
  ) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> topicsRefs<T extends Object>(
    Expression<T> Function($$TopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool topicsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (topicsRefs) db.topics],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      Topic
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._topicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(db, table, p0).topicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool topicsRefs})
    >;
typedef $$TopicsTableCreateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      Value<String?> description,
    });
typedef $$TopicsTableUpdateCompanionBuilder =
    TopicsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<String?> description,
    });

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, Topic> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
        $_aliasNameGenerator(db.topics.categoryId, db.categories.id),
      );

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FixTransactionsTable, List<FixTransaction>>
  _fixTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fixTransactions,
    aliasName: $_aliasNameGenerator(db.topics.id, db.fixTransactions.topicId),
  );

  $$FixTransactionsTableProcessedTableManager get fixTransactionsRefs {
    final manager = $$FixTransactionsTableTableManager(
      $_db,
      $_db.fixTransactions,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _fixTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VarTransactionsTable, List<VarTransaction>>
  _varTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.varTransactions,
    aliasName: $_aliasNameGenerator(db.topics.id, db.varTransactions.topicId),
  );

  $$VarTransactionsTableProcessedTableManager get varTransactionsRefs {
    final manager = $$VarTransactionsTableTableManager(
      $_db,
      $_db.varTransactions,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _varTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> fixTransactionsRefs(
    Expression<bool> Function($$FixTransactionsTableFilterComposer f) f,
  ) {
    final $$FixTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> varTransactionsRefs(
    Expression<bool> Function($$VarTransactionsTableFilterComposer f) f,
  ) {
    final $$VarTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> fixTransactionsRefs<T extends Object>(
    Expression<T> Function($$FixTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FixTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fixTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FixTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.fixTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> varTransactionsRefs<T extends Object>(
    Expression<T> Function($$VarTransactionsTableAnnotationComposer a) f,
  ) {
    final $$VarTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.varTransactions,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VarTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.varTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicsTable,
          Topic,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (Topic, $$TopicsTableReferences),
          Topic,
          PrefetchHooks Function({
            bool categoryId,
            bool fixTransactionsRefs,
            bool varTransactionsRefs,
          })
        > {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => TopicsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
              }) => TopicsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TopicsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                fixTransactionsRefs = false,
                varTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fixTransactionsRefs) db.fixTransactions,
                    if (varTransactionsRefs) db.varTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$TopicsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$TopicsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fixTransactionsRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          FixTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._fixTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).fixTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (varTransactionsRefs)
                        await $_getPrefetchedData<
                          Topic,
                          $TopicsTable,
                          VarTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._varTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).varTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicsTable,
      Topic,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (Topic, $$TopicsTableReferences),
      Topic,
      PrefetchHooks Function({
        bool categoryId,
        bool fixTransactionsRefs,
        bool varTransactionsRefs,
      })
    >;
typedef $$FixTransactionsTableCreateCompanionBuilder =
    FixTransactionsCompanion Function({
      Value<int> id,
      required int topicId,
      required Status status,
      required DateTime start,
      required DateTime end,
      required int intervalCount,
      required IntervalUnit intervalUnit,
      required int value,
      Value<String?> compensations,
      Value<String?> decription,
    });
typedef $$FixTransactionsTableUpdateCompanionBuilder =
    FixTransactionsCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<Status> status,
      Value<DateTime> start,
      Value<DateTime> end,
      Value<int> intervalCount,
      Value<IntervalUnit> intervalUnit,
      Value<int> value,
      Value<String?> compensations,
      Value<String?> decription,
    });

final class $$FixTransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $FixTransactionsTable, FixTransaction> {
  $$FixTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) => db.topics.createAlias(
    $_aliasNameGenerator(db.fixTransactions.topicId, db.topics.id),
  );

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FixTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Status, Status, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<IntervalUnit, IntervalUnit, String>
  get intervalUnit => $composableBuilder(
    column: $table.intervalUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intervalUnit => $composableBuilder(
    column: $table.intervalUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FixTransactionsTable> {
  $$FixTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Status, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get intervalCount => $composableBuilder(
    column: $table.intervalCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<IntervalUnit, String> get intervalUnit =>
      $composableBuilder(
        column: $table.intervalUnit,
        builder: (column) => column,
      );

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => column,
  );

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FixTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FixTransactionsTable,
          FixTransaction,
          $$FixTransactionsTableFilterComposer,
          $$FixTransactionsTableOrderingComposer,
          $$FixTransactionsTableAnnotationComposer,
          $$FixTransactionsTableCreateCompanionBuilder,
          $$FixTransactionsTableUpdateCompanionBuilder,
          (FixTransaction, $$FixTransactionsTableReferences),
          FixTransaction,
          PrefetchHooks Function({bool topicId})
        > {
  $$FixTransactionsTableTableManager(
    _$AppDatabase db,
    $FixTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FixTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FixTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FixTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<Status> status = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime> end = const Value.absent(),
                Value<int> intervalCount = const Value.absent(),
                Value<IntervalUnit> intervalUnit = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<String?> compensations = const Value.absent(),
                Value<String?> decription = const Value.absent(),
              }) => FixTransactionsCompanion(
                id: id,
                topicId: topicId,
                status: status,
                start: start,
                end: end,
                intervalCount: intervalCount,
                intervalUnit: intervalUnit,
                value: value,
                compensations: compensations,
                decription: decription,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required Status status,
                required DateTime start,
                required DateTime end,
                required int intervalCount,
                required IntervalUnit intervalUnit,
                required int value,
                Value<String?> compensations = const Value.absent(),
                Value<String?> decription = const Value.absent(),
              }) => FixTransactionsCompanion.insert(
                id: id,
                topicId: topicId,
                status: status,
                start: start,
                end: end,
                intervalCount: intervalCount,
                intervalUnit: intervalUnit,
                value: value,
                compensations: compensations,
                decription: decription,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FixTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (topicId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.topicId,
                                referencedTable:
                                    $$FixTransactionsTableReferences
                                        ._topicIdTable(db),
                                referencedColumn:
                                    $$FixTransactionsTableReferences
                                        ._topicIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FixTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FixTransactionsTable,
      FixTransaction,
      $$FixTransactionsTableFilterComposer,
      $$FixTransactionsTableOrderingComposer,
      $$FixTransactionsTableAnnotationComposer,
      $$FixTransactionsTableCreateCompanionBuilder,
      $$FixTransactionsTableUpdateCompanionBuilder,
      (FixTransaction, $$FixTransactionsTableReferences),
      FixTransaction,
      PrefetchHooks Function({bool topicId})
    >;
typedef $$VarTransactionsTableCreateCompanionBuilder =
    VarTransactionsCompanion Function({
      Value<int> id,
      required int topicId,
      required DateTime date,
      required int value,
      Value<String?> compensations,
      Value<String?> decription,
      Value<int?> fixRefId,
      Value<int?> varRefId,
    });
typedef $$VarTransactionsTableUpdateCompanionBuilder =
    VarTransactionsCompanion Function({
      Value<int> id,
      Value<int> topicId,
      Value<DateTime> date,
      Value<int> value,
      Value<String?> compensations,
      Value<String?> decription,
      Value<int?> fixRefId,
      Value<int?> varRefId,
    });

final class $$VarTransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VarTransactionsTable, VarTransaction> {
  $$VarTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicsTable _topicIdTable(_$AppDatabase db) => db.topics.createAlias(
    $_aliasNameGenerator(db.varTransactions.topicId, db.topics.id),
  );

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<int>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VarTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixRefId => $composableBuilder(
    column: $table.fixRefId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get varRefId => $composableBuilder(
    column: $table.varRefId,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VarTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixRefId => $composableBuilder(
    column: $table.fixRefId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get varRefId => $composableBuilder(
    column: $table.varRefId,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VarTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VarTransactionsTable> {
  $$VarTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get compensations => $composableBuilder(
    column: $table.compensations,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decription => $composableBuilder(
    column: $table.decription,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fixRefId =>
      $composableBuilder(column: $table.fixRefId, builder: (column) => column);

  GeneratedColumn<int> get varRefId =>
      $composableBuilder(column: $table.varRefId, builder: (column) => column);

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VarTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VarTransactionsTable,
          VarTransaction,
          $$VarTransactionsTableFilterComposer,
          $$VarTransactionsTableOrderingComposer,
          $$VarTransactionsTableAnnotationComposer,
          $$VarTransactionsTableCreateCompanionBuilder,
          $$VarTransactionsTableUpdateCompanionBuilder,
          (VarTransaction, $$VarTransactionsTableReferences),
          VarTransaction,
          PrefetchHooks Function({bool topicId})
        > {
  $$VarTransactionsTableTableManager(
    _$AppDatabase db,
    $VarTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VarTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VarTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VarTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> topicId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> value = const Value.absent(),
                Value<String?> compensations = const Value.absent(),
                Value<String?> decription = const Value.absent(),
                Value<int?> fixRefId = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
              }) => VarTransactionsCompanion(
                id: id,
                topicId: topicId,
                date: date,
                value: value,
                compensations: compensations,
                decription: decription,
                fixRefId: fixRefId,
                varRefId: varRefId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int topicId,
                required DateTime date,
                required int value,
                Value<String?> compensations = const Value.absent(),
                Value<String?> decription = const Value.absent(),
                Value<int?> fixRefId = const Value.absent(),
                Value<int?> varRefId = const Value.absent(),
              }) => VarTransactionsCompanion.insert(
                id: id,
                topicId: topicId,
                date: date,
                value: value,
                compensations: compensations,
                decription: decription,
                fixRefId: fixRefId,
                varRefId: varRefId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VarTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (topicId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.topicId,
                                referencedTable:
                                    $$VarTransactionsTableReferences
                                        ._topicIdTable(db),
                                referencedColumn:
                                    $$VarTransactionsTableReferences
                                        ._topicIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VarTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VarTransactionsTable,
      VarTransaction,
      $$VarTransactionsTableFilterComposer,
      $$VarTransactionsTableOrderingComposer,
      $$VarTransactionsTableAnnotationComposer,
      $$VarTransactionsTableCreateCompanionBuilder,
      $$VarTransactionsTableUpdateCompanionBuilder,
      (VarTransaction, $$VarTransactionsTableReferences),
      VarTransaction,
      PrefetchHooks Function({bool topicId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$FixTransactionsTableTableManager get fixTransactions =>
      $$FixTransactionsTableTableManager(_db, _db.fixTransactions);
  $$VarTransactionsTableTableManager get varTransactions =>
      $$VarTransactionsTableTableManager(_db, _db.varTransactions);
}
