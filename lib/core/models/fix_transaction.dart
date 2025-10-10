import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';

class FixTransaction {
  final int id;
  final Topic topic;
  final Status status;
  final Polarity type;
  final DateTime start;
  final DateTime end;
  final int interval;
  final int value;
  final Compensation compensation;
  final String? description;

  const FixTransaction({
    required this.id,
    required this.topic,
    required this.status,
    required this.type,
    required this.start,
    required this.end,
    required this.interval,
    required this.value,
    required this.compensation,
    this.description
  });
}
