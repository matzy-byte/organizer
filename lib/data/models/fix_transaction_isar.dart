import 'package:isar/isar.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/data/models/topic_isar.dart';

part 'fix_transaction_isar.g.dart';

@collection
class FixTransactionIsar {
  Id id = Isar.autoIncrement;
  final topic = IsarLink<TopicIsar>();
  @enumerated
  late Status status;
  @enumerated
  late Polarity type;
  late DateTime start;
  late DateTime end;
  late int intervalCount;
  @enumerated
  late IntervalUnit intervalUnit;
  late int value;
  @enumerated
  late Compensation compensation;
  String? description;
}