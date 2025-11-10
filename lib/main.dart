import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/test_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Note this is STATELESS. Therefore the final output is immutable.
  // This may not be correct...
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
  double sliderPos = 10;
  double tipPercentPerPerson = 10;

  // todo:
  double totalCost = 0.0;

  double _tipPercentage = 0.0;
  // he may do sometihng to dynamically work out the tics on the slider.

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

  //  This WORKS to update the slider pos value on dragging - is
  // it the way he does it?
  void setSliderValue(tipPercentage) {
    setState(() => {});
    debugPrint("sliding to $tipPercentage...");
    // this is nice, but a little crude.
    sliderPos = tipPercentPerPerson = tipPercentage;

    // return val;
    // updatedVal:ValueChanged = 12;
    // return ValueChanged.
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
          // Row(
          //   children: [
          //     Text("TEST"),
          //     Text(now),
          //     TestWidget(setsomething: setSomething, result: now),
          //   ],
          // ),
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
                      // Text("\$20 [placeholder]"),
                      Text("\$5000}"),
                    ],
                  ),
                  // slider text:
                  // why does this stay centred?
                  // This ALSO works
                  Text("Tip %: ${tipPercentPerPerson.round()}"),

                  // and he does:
                  Text("Tip: ${(_tipPercentage * 100).round()}%"),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [Text("Tip PP")],
                  // ),

                  // tip slider: a Slider widget!
                  Slider(
                    /** */
                    min: 0,
                    max: 50,
                    value: sliderPos,
                    // note the contextual val here - this is from the Slider widget
                    // (based upon the current min/max settings)
                    onChanged: (val) => {setSliderValue(val)}, // MINE - working
                    //
                    //
                    // he does this:
                    // a hover label over slider pos
                    label: '${tipPercentPerPerson.round()}%',
                    // points at which the label shows:
                    divisions: 10,
                    /**
                    min: 0.0,
                    max: 0.5,
                    value: (_tipPercentage),
                    // doesn't work yet...
                    onChanged: (val) {
                      // so he puts in setState:
                      setState(() {
                        _tipPercentage = val;
                        debugPrint("$_tipPercentage");
                      });
                    },
                     */
                  ),

                  Text("BOB!"),
                ],
                // tip percentage
              ),
            ),
          ),
        ],
      ),
    );
  }
}
