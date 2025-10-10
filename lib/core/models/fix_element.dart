import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';

class FixElement {
  final String id;
  final Category category;
  final Polarity type;
  final DateTime start;
  final DateTime end;
  final int interval;
  final int value;
  final Compensation compensation;
  final String? description;

  const FixElement({
    required this.id,
    required this.category,
    required this.type,
    required this.start,
    required this.end,
    required this.interval,
    required this.value,
    required this.compensation,
    this.description
  });
}
