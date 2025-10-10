import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';

class VarTransaction {
  final int id;
  final Topic topic;
  final Polarity type;
  final DateTime date;
  final int value;
  final Compensation compensation;
  final String? description;
  
  VarTransaction({
    required this.id,
    required this.topic,
    required this.type,
    required this.date,
    required this.value,
    required this.compensation,
    this.description
  });
}
