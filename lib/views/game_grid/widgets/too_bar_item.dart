import 'package:flutter/material.dart';

import 'package:sudoku/utilties/my_constant/my_constants.dart';

class ToolsBarItem extends StatelessWidget {
  const ToolsBarItem(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.iconShape});
  final String text;
  final Function onPressed;
  final IconData iconShape;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            onPressed();
          },
          icon: Icon(
            iconShape,
            color: primaryColor,
            size: 35,
          ),
        ),
        Text(
          text,
          style: meduimLightTextStyle,
        )
      ],
    );
  }
}
