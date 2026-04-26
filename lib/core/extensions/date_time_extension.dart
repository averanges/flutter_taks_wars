import 'package:flutter_soft_wars/core/extensions/string_extension.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dayMonthYear() => '$day ${DateFormat("MMMM", 'uk').format(this).capitalize()} $year';

  String frontDayMonthYear() {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  String yearMonthDay() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
