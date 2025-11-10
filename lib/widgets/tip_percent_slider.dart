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
  Function setSliderValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      /** */
      min: 0,
      max: 50,
      value: sliderPos,
      // note the contextual val here - this is from the Slider widget
      // (based upon the current min/max settings)
      // 6.20 - extract to widget. Comment this out first as errors
      // onChanged: (val) => {setSliderValue(val)}, // MINE - working
      onChanged: (val) {
        //to reinstate method call
        setSliderValue(val);
      },

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
    );
  }
}
