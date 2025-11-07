import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  // I get a mutable warning
  const TestWidget({
    super.key,
    required this.setsomething, // a func passed in. required is required
    required this.result, // an UPDATED VARIABLE passed in...
    // OK it IS the same as the course example. But still... This seems like
    // state in a stateless widget?
    // THIS:
    // https://stackoverflow.com/questions/62751380/can-a-statelesswidget-contain-member-variables
    // suggests that this (and he course one) should be STATEFUL widgets.  To continue.

    // and here, we can pass in other constructor args, including function refs.
  });

  final VoidCallback setsomething; // needs to be final
  final String result;

  @override
  Widget build(BuildContext context) {
    return Row(
      // removed `const`?
      children: [
        IconButton(onPressed: setsomething, icon: Icon(Icons.access_alarm)),
        Text(result),
      ],
    );
    // HERE we insert our widget code, replacing the Placeholder widget
  }
}
