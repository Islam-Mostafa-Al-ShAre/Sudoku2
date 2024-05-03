// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff07A2DF);
const Color SecondaryColor = Color.fromARGB(255, 194, 228, 240);
Color backgroundColor = Colors.grey.shade300;

TextStyle smallBoldTextStyle =
    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
TextStyle LargeTextStyle = const TextStyle(
  fontSize: 30,
);

TextStyle smallLightTextStyle =
    TextStyle(fontSize: 15, color: Colors.grey.shade600);
TextStyle meduimLightTextStyle =
    TextStyle(fontSize: 20, color: Colors.grey.shade600);

BoxDecoration squareBoldBorder = BoxDecoration(
  color: Colors.grey.shade200,
  border: Border.all(color: Colors.black, width: 2),
);
BoxDecoration squarelightBorder = BoxDecoration(
  color: Colors.grey.shade200,
  border: Border.all(color: const Color.fromARGB(255, 204, 204, 204), width: 1),
);
