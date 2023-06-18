import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../global/data.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 200,
            child: Chart(
              data: basicData,
              variables: {
                'status': Variable(
                  accessor: (Map map) => map['status'] as String,
                ),
                'amount': Variable(
                  accessor: (Map map) => map['amount'] as num,
                ),
              },
              transforms: [
                Proportion(
                  variable: 'amount',
                  as: 'percent',
                )
              ],
              marks: [
                IntervalMark(
                  position: Varset('percent') / Varset('status'),
                  label: LabelEncode(
                      encoder: (tuple) => Label(
                            tuple['amount'].toString(),
                            LabelStyle(textStyle: Defaults.runeStyle),
                          )),
                  color: ColorEncode(
                    variable: 'status',
                    values: [
                      Colors.green,
                      Colors.red,
                    ],
                  ),
                  modifiers: [StackModifier()],
                )
              ],
              coord: PolarCoord(transposed: true, dimCount: 1),
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Container(color: Colors.red),
                    ),
                    const Text(
                      "  Balance Left: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "  ₱ 110000",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),

                //Payment Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Container(color: Colors.green),
                    ),
                    const Text(
                      "  Paid Amount: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "  ₱ 4000",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Payment Date
        ],
      ),
    );
  }
}
