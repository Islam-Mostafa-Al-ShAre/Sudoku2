import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sudoku/controllers/game_controllers.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';
import 'package:sudoku/views/game_grid/widgets/info_bar_child.dart';

class InfoBar extends StatelessWidget {
  InfoBar({super.key});
  final GameController _gameController = GameController.instance;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.back_hand,
              size: 30,
            ),
          ),
          GetX<GameController>(
            builder: (controller) {
              int minutes = _gameController.time ~/ 60;
              int sec = _gameController.time % 60;
              return Column(
                children: [
                  Text("Time", style: smallLightTextStyle),
                  Text("$minutes :$sec", style: smallBoldTextStyle)
                ],
              );
            },
          ),
          const InfoBarChild(title: "Score", value: 120),
          GetBuilder<GameController>(
            builder: (controller) {
              return Column(
                children: [
                  Text("Mistakes", style: smallLightTextStyle),
                  Text(_gameController.mistakes.toString(),
                      style: smallBoldTextStyle)
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
