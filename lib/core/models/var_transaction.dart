import 'package:organizer/core/models/compensation_info.dart';

class VarTransaction {
  final int id;
  final int topicId;
  final DateTime date;
  final int value;
  final int userRefId;
  final DateTime lastEdit;
  final Map<int, CompensationInfo>? compensations;
  final int? transactionLabelId;
  final String? description;
  final int? fixRefId;
  final int? varRefId;
  final int? fileRefId;

  VarTransaction({
    required this.id,
    required this.topicId,
    required this.date,
    required this.value,
    required this.userRefId,
    required this.lastEdit,
    this.compensations,
    this.transactionLabelId,
    this.description,
    this.fixRefId,
    this.varRefId,
    this.fileRefId,
  });
}
