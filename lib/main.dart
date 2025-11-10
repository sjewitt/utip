import 'package:flutter/material.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_percent_slider.dart';
import 'package:utip/widgets/test_widget.dart';

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

  // todo:
  double totalCost = 0.0;

  void decrementCounter() {
    setState(() {
      if (personCount > 0) personCount--;
    });
  }

  void incrementCounter() {
    setState(() {
      personCount++;
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
                  "\$20.99",
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),

              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: "Total cost:",
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (String value) {
                      // call handler here to set the totalCost var
                      debugPrint(
                        "VARS: $value, $personCount, $tipPercentPerPerson",
                      );
                    },
                  ),
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
                      Text("\$5000}"),
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
