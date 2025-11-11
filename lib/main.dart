// see https://stackoverflow.com/questions/75097840/is-double-and-double-are-different-thing-in-dart-and-if-it-is-can-anyone-explain
// import 'dart:ffi';  // contains Double. We actually want `double`

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utip/widgets/bill_amt_text_field.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_percent_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Note this is STATELESS. Therefore the final output should be immutable. This may not be correct...
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int personCount = 0;
  String now = "";
  double sliderval = 0.0;
  // initial value of sliderPos (e.g. the proposed tip starting value)
  double sliderPos = 0;
  double tipPercentPerPerson = 0;

  double tipPerPerson = 0;
  double costPerPerson = 0;

  // todo:
  double totalCost = 0.0;

  String finalCostPerPersonOutput = "0.00";
  String finalOutput = "0.00";

  // person counter handlers:
  void decrementCounter() {
    setState(() {
      if (personCount > 0) personCount--;
      debugPrint("Current bill: $totalCost");
      debugPrint("Current guest count: $personCount");
      // and as I have the totalCost - which is the same as the text field
      // value - I can call the same method as the cahne handler on the text box:
      handleBillAmount(totalCost);
    });
  }

  void incrementCounter() {
    setState(() {
      personCount++;
      debugPrint("Current bill: $totalCost");
      debugPrint("Current guest count: $personCount");
      // and as I have the totalCost - which is the same as the text field
      // value - I can call the same method as the cahne handler on the text box:
      handleBillAmount(totalCost);
    });
  }

  void setSomething() {
    setState(() {
      now = DateTime.now().toIso8601String();
    });
  }

  //  This WORKS to update the slider pos value on dragging - is it the way he does it?
  void setSliderValue(sliderValue) {
    // = `value` in example
    setState(() {
      debugPrint("setting to sliderValue of: $sliderValue...");

      // I DO need all three vars - the TPP is also the tooltip!
      tipPercentPerPerson = sliderPos = sliderValue;

      debugPrint("Current bill: $totalCost");
      debugPrint("Current guest count: $personCount");

      // and as I have the totalCost - which is the same as the text field
      // value - I can call the same method as the cahne handler on the text box:
      handleBillAmount(totalCost);
    });
  }

  // handler for total cost (blur?, on personcounter change?)
  // `value` comes from the input field
  void handleBillAmount(totalBillAmount) {
    setState(() {
      if (totalBillAmount is String) {
        debugPrint("Its a trap! $totalBillAmount");
        // This'll need exception handling:
        totalBillAmount = double.parse(
          totalBillAmount,
        ); // hmm... double vs Double types...
      }
      if (totalBillAmount is double) {
        debugPrint("Its a sausage! $totalBillAmount");
      }
      //See https://flutterdata.dev/articles/checking-null-aware-operators-dart/ re null checking
      // umm... this threw an exception...
      // totalBillAmount = double.tryParse(totalBillAmount);
      /**
       * It's now a float, or default of 0, so we can work out the amount PP. It will probably 
       * need to be a Currency type.
       */
      if (totalBillAmount != null) {
        totalCost = totalBillAmount;
        debugPrint("Bill amount is \$$totalBillAmount");
        debugPrint("There are $personCount guests");
        debugPrint("Tip percentage is $sliderPos");
        if (personCount > 0) {
          costPerPerson = totalBillAmount / personCount;
          debugPrint("Amount per person: $costPerPerson");
          tipPerPerson = (totalBillAmount * (sliderPos / 100)) / personCount;
          debugPrint("Tip amount per person: $tipPerPerson");
        } else {
          debugPrint("No guests!");
        }
      } else {
        tipPerPerson = 0.0;
      }

      // and format the tip per person as currency:
      // https://stackoverflow.com/questions/14865568/currency-format-in-dart
      final formatCurrency = NumberFormat.simpleCurrency(locale: "en_GB");
      finalOutput = formatCurrency.format(tipPerPerson);
      finalCostPerPersonOutput = formatCurrency.format(costPerPerson);
      debugPrint("Tip amount per person: $finalOutput");
      // TODO: trigger change from all widgets. - DONE
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("UTip")),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,

        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.inversePrimary,
              border: BoxBorder.all(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),

            margin: EdgeInsets.all(3),
            padding: EdgeInsets.all(18),

            child: Column(
              children: [
                Text("Total per person:", style: style),
                Text(
                  // "\$$tipPerPerson",
                  finalCostPerPersonOutput, // this is a formatted currency string
                  style: style.copyWith(
                    fontSize: theme.textTheme.displaySmall!.fontSize,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),

              child: Column(
                children: [
                  // bill amout widget
                  BillAmtTextField(
                    // he also passes in the value?
                    // the value is implicit in the args...

                    // mine
                    personCount: personCount,
                    tipPercentPerPerson: tipPercentPerPerson,
                    handleBillAmount: handleBillAmount, // the handler function
                  ),

                  // person counter widget
                  PersonCounter(
                    theme: theme,
                    personCount: personCount,
                    onDecrement: decrementCounter,
                    onIncrement: incrementCounter,
                  ),

                  // Tip section
                  Row(
                    // force to full width, as per person counter:
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip", style: theme.textTheme.titleMedium),
                      Text(finalOutput), // this is a formatted currency string
                    ],
                  ),
                  // slider text:
                  // why does this stay centred?
                  // This ALSO works
                  // I have already factored by 1/100 before the value gets here:
                  Text("Tip %: ${tipPercentPerPerson.round()}"),

                  // and he does:
                  // Text("Tip: ${(_tipPercentage * 100).round()}%"),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [Text("Tip PP")],
                  // ),

                  // tip slider: a Slider widget!
                  TipPercentSlider(
                    sliderPos: sliderPos,
                    tipPercentPerPerson: tipPercentPerPerson,
                    setSliderValue: setSliderValue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
