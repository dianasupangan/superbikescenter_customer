import 'package:intl/intl.dart';

String dateNow() {
  final year = DateFormat.y().format(DateTime.now()).toString();

  return year + month() + day();
}

String month() {
  String month = DateFormat.M().format(DateTime.now()).toString();

  if (int.parse(month) < 10) {
    return "0$month";
  } else {
    return month;
  }
}

String day() {
  String day = DateFormat.d().format(DateTime.now()).toString();

  if (int.parse(day) < 10) {
    return "0$day";
  } else {
    return day;
  }
}
