import 'package:flutter/material.dart';

class TipPercentSlider extends StatelessWidget {
  TipPercentSlider({
    // removed constant. It's a STATEFUL widget!!
    super.key,
    required this.sliderPos,
    required this.tipPercentPerPerson,
    required this.setSliderValue,
  });

  final double sliderPos;
  final double tipPercentPerPerson;

  // Function setSliderValue;

  // he does this (note cast to return type):
  // This ValueChanged object seems to be quite crucial:
  final ValueChanged<double> setSliderValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 50,
      value: sliderPos,
      onChanged: (val) => {setSliderValue(val)},

      label: '${tipPercentPerPerson.round()}%',
      divisions: 50, // more granular tip slider
    );
  }
}
