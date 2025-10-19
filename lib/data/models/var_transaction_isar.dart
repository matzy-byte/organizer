import 'package:isar/isar.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/data/models/fix_transaction_isar.dart';
import 'package:organizer/data/models/topic_isar.dart';

part 'var_transaction_isar.g.dart';

@collection
class VarTransactionIsar {
  Id id = Isar.autoIncrement;
  final topic = IsarLink<TopicIsar>();
  @enumerated
  late Polarity type;
  late DateTime date;
  late int value;
  
  late String? compensations;
  String? description;
  final fixReference = IsarLink<FixTransactionIsar>();
}