import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'date.dart';

String cywareCodeLogIn(String loandID) {
  final cyware_key = "login$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cyware_key)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}

String cywareCodeOtp(String loandID) {
  final cyware_key = "verify$loandID${dateNow()}";
  final convert = md5.convert(utf8.encode(cyware_key)).toString();

  final finalConvert = md5.convert(utf8.encode(convert)).toString();

  return finalConvert;
}
