import 'package:organizer/core/models/compensation_info.dart';

class VarTransaction {
  final int id;
  final int topicId;
  final DateTime date;
  final int value;
  final Map<int, CompensationInfo>? compensations;
  final String? description;
  final int? fixRefId;
  final int? varRefId;

  VarTransaction({
    required this.id,
    required this.topicId,
    required this.date,
    required this.value,
    this.compensations,
    this.description,
    this.fixRefId,
    this.varRefId,
  });
}
