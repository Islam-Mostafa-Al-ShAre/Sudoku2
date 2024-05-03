import 'package:flutter/material.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';

class InfoBarChild extends StatelessWidget {
  const InfoBarChild({super.key, required this.title, required this.value});
  final String title;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: smallLightTextStyle),
        Text(value.toString(), style: smallBoldTextStyle)
      ],
    );
  }
}
