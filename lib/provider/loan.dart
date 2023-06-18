import 'package:flutter/material.dart';

class LoanInfo {
  final String paymentDate;
  final String paymentAmount;
  final String receiptNumber;

  LoanInfo({
    required this.paymentDate,
    required this.paymentAmount,
    required this.receiptNumber,
  });
}

class Loan extends ChangeNotifier {
  final List<LoanInfo> items = [];

  void add(
    String pDate,
    String pAmount,
    String rNumber,
  ) async {
    items.add(
      LoanInfo(
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
