import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';

myDialog(BuildContext context, String title) {
  return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Note',
          desc: title,
          btnOkOnPress: () {},
          btnOkColor: primaryColor)
      .show();
}
