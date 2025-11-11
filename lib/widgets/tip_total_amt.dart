import 'package:flutter/material.dart';

class TipTotalAmount extends StatelessWidget {
  const TipTotalAmount({
    super.key,
    required this.theme,
    required this.finalTipTotalOutput,
  });

  final ThemeData theme;
  final String finalTipTotalOutput;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total tip amount:", style: theme.textTheme.titleMedium),
        Text(finalTipTotalOutput), // he again uses total.toStringAsFixed(2);
      ],
    );
  }
}
