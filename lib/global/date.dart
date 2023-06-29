import 'package:intl/intl.dart';

String dateNow() {
  String month = DateFormat.M().format(DateTime.now()).toString();
  final day = DateFormat.d().format(DateTime.now()).toString();
  final year = DateFormat.y().format(DateTime.now()).toString();

  if (int.parse(month) < 10) {
    return year + "0$month" + day;
  } else {
    return year + month + day;
  }
}
