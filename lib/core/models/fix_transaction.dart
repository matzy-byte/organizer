import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';

class FixTransaction {
  final int id;
  final int topicId;
  final Status status;
  final DateTime start;
  final DateTime end;
  final int intervalCount;
  final IntervalUnit intervalUnit;
  final int value;
  final Map<int, CompensationInfo>? compensations;
  final String? description;

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
    this.description,
  });
}
