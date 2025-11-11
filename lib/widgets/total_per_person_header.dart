import 'package:flutter/material.dart';

class TotalPerPersonHeader extends StatelessWidget {
  const TotalPerPersonHeader({
    super.key,
    required this.theme,
    required this.style,
    required this.finalCostPerPersonOutput,
  });

  final ThemeData theme;
  final TextStyle style;
  final String finalCostPerPersonOutput;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            finalCostPerPersonOutput, // this is a formatted currency string
            // 6.23 - he actually uses thing.toStringAsFixed(2);
            style: style.copyWith(
              fontSize: theme.textTheme.displaySmall!.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
