import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillAmtTextField extends StatelessWidget {
  const BillAmtTextField({
    super.key,
    required this.personCount,
    required this.tipPercentPerPerson,
    required this.handleBillAmount,
  });

  final int personCount;
  final double tipPercentPerPerson;

  // the handler function (see person_counter)
  final ValueChanged<String> handleBillAmount;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        // prefixIcon: Icon(Icons.attach_money),
        // can this be made contextually aware?
        prefixIcon: Icon(Icons.currency_pound),
        labelText: "Total cost:",
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: handleBillAmount,

      // he does this (which is the same as above? `value is implicit?`):
      // onChanged: (String value) {
      //   handleBillAmount(value);
      // },
    );
  }
}
