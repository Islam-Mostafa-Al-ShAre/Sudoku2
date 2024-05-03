import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';
import 'package:sudoku/views/home_screen.dart';

AppBar gameAppBar(
  String title,
) {
  return AppBar(
    actions: [
      IconButton(
          onPressed: () {
            Get.offAll(() => Home());
          },
          icon: Icon(Icons.home))
    ],
    title: Text(title),
    centerTitle: true,
    backgroundColor: primaryColor,
    elevation: .9,
    shadowColor: Colors.red,
  );
}
