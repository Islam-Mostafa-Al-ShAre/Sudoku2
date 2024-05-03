import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sudoku/controllers/game_controllers.dart';
import 'package:sudoku/controllers/home_controller.dart';
import 'package:sudoku/views/game_grid/widgets/too_bar_item.dart';

class ToolsBar extends StatelessWidget {
  ToolsBar({super.key});
  final GameController _gameController = GameController.instance;
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ToolsBarItem(
            iconShape: FontAwesomeIcons.lightbulb,
            text: "Hint",
            onPressed: () async {
              _gameController.getHint();
            }),
        ToolsBarItem(
            iconShape: FontAwesomeIcons.eraser,
            text: "Delete",
            onPressed: () {
              _gameController.deleteNumInSelectedBox();
            }),
        ToolsBarItem(
            iconShape: FontAwesomeIcons.arrowRotateLeft,
            text: "Back",
            onPressed: () {
              _gameController.backOneStep();
            })
      ],
    );
  }
}
