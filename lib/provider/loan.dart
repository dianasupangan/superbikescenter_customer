import 'package:flutter/material.dart';

class UserInfo {
  final String paymentDate;
  final String paymentAmount;
  final String receiptNumber;

  UserInfo({
    required this.paymentDate,
    required this.paymentAmount,
    required this.receiptNumber,
  });
}

class User extends ChangeNotifier {
  final List<UserInfo> items = [];

  void add(
    String pDate,
    String pAmount,
    String rNumber,
  ) async {
    items.add(
      UserInfo(
        paymentDate: pDate,
        paymentAmount: pAmount,
        receiptNumber: rNumber,
      ),
    );

    notifyListeners();
  }

  void clear() {
    items.clear();

    notifyListeners();
  }
}
