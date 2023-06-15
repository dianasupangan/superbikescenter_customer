import 'package:flutter/material.dart';

class UserInfo {
  final String loanID;
  final String firstName;
  final String lastName;
  final String loanStatus;
  final String loanTerms;
  final String numberMonthsPaid;

  UserInfo({
    required this.loanID,
    required this.firstName,
    required this.lastName,
    required this.loanStatus,
    required this.loanTerms,
    required this.numberMonthsPaid,
  });
}

class User extends ChangeNotifier {
  final List<UserInfo> items = [];

  void add(
    String lId,
    String fName,
    String lName,
    String lStatus,
    String lTerms,
    String numMonthsPaid,
  ) async {
    items.add(
      UserInfo(
        loanID: lId,
        firstName: fName,
        lastName: lName,
        loanStatus: lStatus,
        loanTerms: lTerms,
        numberMonthsPaid: numMonthsPaid,
      ),
    );
    notifyListeners();
  }

  void clear() {
    items.clear();

    notifyListeners();
  }
}
