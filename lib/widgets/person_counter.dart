// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
// How to MANUALLY exctract the widget?
// put the method refs back here?
// the callbacks will be passed as callback args to the new widget. See below

class PersonCounter extends StatelessWidget {
  const PersonCounter({
    super.key,
    required this.theme,
    required this.personCount,
    // adds these to remove the bitching:
    // this also enforces the requirement for passing the callback functions
    required this.onDecrement,
    required this.onIncrement,
  });

  final ThemeData theme;
  final int personCount;

  // #6:15
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween, // huh? He talks about this (to `start`) but then removes it?//.spaceBetween also works (and dont need )

      children: [
        Text("Split bill by:", style: theme.textTheme.titleMedium),
        // note nested Row()
        // 6.15 refactor.
        // The extract Widget quick menu option here triggers a warning, to do with the handler methods.
        // therefore, temorarily remove them and replace with anon empty functions
        Row(
          // mainAxisAlignment: MainAxisAlignment.end,  // not needed
          // the inc/dec controls:
          children: [
            IconButton(
              color: theme.colorScheme.primary,
              //NOTE: If the handler is null, then the buttons become disabled. Therefore, add a dummy anon function:
              // onPressed: null,
              // onPressed: decrementCounter,
              // onPressed: () => {},
              // becomes
              onPressed: onDecrement,
              // () => {
              //   // personCount = personCount - 1,
              //   // debugPrint("removing")
              // },
              icon: const Icon(Icons.remove),
            ),
            // counter
            // note use of $ in string to coerce the int to a string
            Text("$personCount", style: theme.textTheme.titleMedium),
            IconButton(
              color: theme.colorScheme.primary,
              //NOTE: If the handler is null, then the buttons become disabled. Therefore, add a dummy anon function:
              // onPressed: null,
              // onPressed: () => personCount++,
              // onPressed: incrementCounter,
              // onPressed: () => {},
              // becomes
              onPressed: onIncrement,

              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ], // TODO:
    );
  }
}
