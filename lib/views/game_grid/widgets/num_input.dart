import 'package:flutter/material.dart';
import 'package:sudoku/controllers/game_controllers.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';
import 'package:sudoku/views/widgets/mydialog.dart';

class NumInput extends StatelessWidget {
  NumInput({super.key, required this.number});
  final GameController _gameController = GameController.instance;
  final int number;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //check if there is selected box
        if (_gameController.getCurrentSelectedBox()?.number != null) {
          //check if selected box is empty
          if (_gameController.getCurrentSelectedBox()!.number == 0) {
            _gameController.checkIfTheNumIsCorrect(number);
          } else {
            //if selected box not empty
            myDialog(context, "This Box Is Already Filled");
          }
        } else {
          // if there is not selected box
          myDialog(context, "You Must Select Box To Play In");
        }
      },
      child: Text(
        number.toString(),
        style: const TextStyle(fontSize: 35, color: primaryColor),
      ),
    );
  }
}
