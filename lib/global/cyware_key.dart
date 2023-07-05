import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'date.dart';

String cywareCodeLogIn(String loandID) {
  final cywareKey = "login$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeOtp(String loandID) {
  final cywareKey = "verify$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeOldNum(String loandID) {
  final cywareKey = "confirm_old_number$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeOldNumOtp(String loandID) {
  final cywareKey = "confirm_old_number_otp$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeNewNum(String loandID) {
  final cywareKey = "update_mobile$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeNewNumOtp(String loandID) {
  final cywareKey = "update_mobile_otp$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cywareKey)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}
