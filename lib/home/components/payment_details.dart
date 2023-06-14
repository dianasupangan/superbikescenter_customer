import 'package:flutter/material.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Payment Date
          Row(
            children: [
              Text(
                "Payment Date: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "Sample",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),

          //Payment Amount
          Row(
            children: [
              Text(
                "Payment Amount: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "Sample",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),

          //OR Number
          Row(
            children: [
              Text(
                "OR Number: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "Sample",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
