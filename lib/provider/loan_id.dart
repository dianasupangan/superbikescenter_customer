import 'package:flutter/material.dart';

class LoanIdInfo {
  final String loanId;

  LoanIdInfo({
    required this.loanId,
  });
}

class LoanId extends ChangeNotifier {
  final List<LoanIdInfo> items = [];

  void add(
    String lId,
  ) async {
    items.add(
      LoanIdInfo(
        loanId: lId,
      ),
    );

    notifyListeners();
  }

  void clear() {
    items.clear();

    notifyListeners();
  }
}
