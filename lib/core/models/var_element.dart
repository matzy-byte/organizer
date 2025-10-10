import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';

class VarElement {
  final String id;
  final Category category;
  final Polarity polarity;
  final DateTime date;
  final int value;
  final Compensation compensation;
  final String? description;
  
  VarElement({
    required this.id,
    required this.category,
    required this.polarity,
    required this.date,
    required this.value,
    required this.compensation,
    this.description
  });
}
