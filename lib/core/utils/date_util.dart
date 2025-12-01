import 'package:organizer/core/models/interval_unit.dart';

class DateUtil {
  static DateTime getFromCurrentMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1, 0, 0, 0);
  }

  static DateTime getToCurrentMonth() {
    final now = DateTime.now();
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    return DateTime(now.year, now.month, lastDay, 23, 59, 59);
  }

  static DateTime addInterval(DateTime base, int count, IntervalUnit unit) {
    switch (unit) {
      case IntervalUnit.day:
        return base.add(Duration(days: count));
      case IntervalUnit.week:
        return base.add(Duration(days: count * 7));
      case IntervalUnit.month:
        return DateTime(base.year, base.month + count, base.day);
      case IntervalUnit.year:
        return DateTime(base.year + count, base.month, base.day);
      case IntervalUnit.decade:
        return DateTime(base.year + count * 10, base.month, base.day);
    }
  }

  static bool sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
