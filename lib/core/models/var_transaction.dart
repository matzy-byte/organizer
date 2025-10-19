import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';

class VarTransaction {
  final int id;
  final Topic topic;
  final Polarity type;
  final DateTime date;
  final int value;
  final Map<int, CompensationInfo>? compensations;
  final String? description;
  final FixTransaction? fixReference;
  
  VarTransaction({
    required this.id,
    required this.topic,
    required this.type,
    required this.date,
    required this.value,
    required this.compensations,
    this.description,
    this.fixReference
  });
}
