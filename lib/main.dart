// see https://stackoverflow.com/questions/75097840/is-double-and-double-are-different-thing-in-dart-and-if-it-is-can-anyone-explain
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:utip/widgets/bill_amt_text_field.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_percent_slider.dart';
import 'package:utip/widgets/tip_total_amt.dart';
import 'package:utip/widgets/total_per_person_header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
  double sliderPos = 0;
  double tipPercentPerPerson = 0;
  double tipPerPerson = 0;
  double tipTotal = 0;
  double costPerPerson = 0;
  double totalCost = 0.0;

  // see https://medium.com/@varsha.vikshith.tech/format-currency-like-a-pro-in-dart-flutter-15a183668241
  String finalCostPerPersonOutput = "0.00";
  String finalTipPerPersonOutput = "0.00";
  String finalTipTotalOutput = "0.00";

  // TODO: https://stackoverflow.com/questions/48836636/how-to-use-functions-of-another-file-in-dart-flutter

  // person counter handlers:
  void decrementCounter() {
    setState(() {
      if (personCount > 1) personCount--;
      handleBillAmount(totalCost);
    });
  }

  void incrementCounter() {
    setState(() {
      personCount++;
      handleBillAmount(totalCost);
    });
  }

  void setSomething() {
    setState(() {
      now = DateTime.now().toIso8601String();
    });
  }

  void setSliderValue(sliderValue) {
    setState(() {
      debugPrint("setting to sliderValue of: $sliderValue...");
      tipPercentPerPerson = sliderPos = sliderValue;
      handleBillAmount(totalCost);
    });
  }

  // course equivalents, for comparison (add logging to check):
  double totalPerPerson() {
    double _total =
        ((totalCost * (tipPercentPerPerson / 100)) + (totalCost)) /
        (personCount);
    return (_total);
  }

  double totalTip() {
    double _tip = ((totalCost * tipPercentPerPerson) / 100);
    return (_tip);
  }

  void handleBillAmount(totalBillAmount) {
    setState(() {
      if (totalBillAmount is String) {
        totalBillAmount = double.parse(totalBillAmount);
      }

      if (totalBillAmount != null) {
        totalCost = totalBillAmount;
        if (personCount > 0) {
          costPerPerson = totalBillAmount / personCount;
          tipTotal =
              totalBillAmount * (sliderPos / 100); // added to account for 6.22
          tipPerPerson = (totalBillAmount * (sliderPos / 100)) / personCount;
        }
      } else {
        tipPerPerson = 0.0;
        tipTotal = 0.0;
      }

      final formatCurrency = NumberFormat.simpleCurrency(locale: "en_GB");

      finalTipPerPersonOutput = formatCurrency.format(tipPerPerson);
      finalTipTotalOutput = formatCurrency.format(tipTotal);
      finalCostPerPersonOutput = formatCurrency.format(
        costPerPerson + tipPerPerson,
      );

      // course method
      totalPerPerson();
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // from course material, for comparison (see console logs):
    double total = totalPerPerson();
    double totalT = totalTip();

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
          TotalPerPersonHeader(
            theme: theme,
            style: style,
            finalCostPerPersonOutput: finalCostPerPersonOutput,
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
                  BillAmtTextField(
                    personCount: personCount,
                    tipPercentPerPerson: tipPercentPerPerson,
                    handleBillAmount: handleBillAmount,
                  ),

                  PersonCounter(
                    theme: theme,
                    personCount: personCount,
                    onDecrement: decrementCounter,
                    onIncrement: incrementCounter,
                  ),

                  // make tip percent display consistent:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip percentage:",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text("${tipPercentPerPerson.round()}%"),
                    ],
                  ),

                  TipTotalAmount(
                    theme: theme,
                    finalTipTotalOutput: finalTipTotalOutput,
                  ),

                  // Text("Tip: ${tipPercentPerPerson.round()}%"),
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
