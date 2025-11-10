import 'package:flutter/material.dart';

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
        prefixIcon: Icon(Icons.attach_money),
        labelText: "Total cost:",
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),

      // onChanged: (String value) {
      //   // TODO: add another method here.
      //   // Is this a state change one? - if it is displayed, or updates a
      //   // widget var, yes.
      //   // call handler here to set the totalCost var
      //   debugPrint("VARS: $value, $personCount, $tipPercentPerPerson");
      // },
      // onChanged: handleBillAmount,

      // he does this (which is the same as above? `value is implicit?`):
      onChanged: (String value) {
        handleBillAmount(value);
      },

      // TODO: Implement the SAME function on change for personCounter and tip slider. Tomorrow...
      onEditingComplete: () {
        // handleBillAmount();
        debugPrint("FISH!!!");
      },
    );
  }
}
