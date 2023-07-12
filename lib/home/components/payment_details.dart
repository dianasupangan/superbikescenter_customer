import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../provider/loan.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    final loanData = Provider.of<Loan>(context, listen: false);
    final formatCurrency = NumberFormat.currency(symbol: "₱");

    final amount = formatCurrency
        .format(double.parse(loanData.items.first.paymentAmount.toString()));
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Last Payment Details:",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Payment Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Payment Date: ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy')
                            .format(DateTime.parse(
                                loanData.items.first.paymentDate.toString()))
                            .toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),

                  //Payment Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Payment Amount: ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        amount,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),

                  //OR Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "OR Number: ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        loanData.items.first.receiptNumber.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
