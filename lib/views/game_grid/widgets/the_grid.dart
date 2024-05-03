import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sudoku/controllers/game_controllers.dart';
import 'package:sudoku/models/Box.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';

class TheGrid extends StatelessWidget {
  TheGrid({
    super.key,
  });

  final GameController gameController = GameController.instance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) {
        return Container(
          height: 400,
          width: 400,
          decoration: squareBoldBorder,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 81,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9, mainAxisSpacing: 0, crossAxisSpacing: 0),
            itemBuilder: (context, index) {
              int row = index ~/ 9;
              int col = index % 9;
              Box box = gameController.boxs[row][col];
              return GestureDetector(
                  onTap: () {
                    gameController.onBoxClick(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: box.inHintStack
                          ? const Color.fromARGB(255, 81, 255, 62)
                          : box.isWrong
                              ? const Color.fromARGB(255, 255, 95, 84)
                              : box.isSelected
                                  ? primaryColor
                                  : box.hasRelationWithSelected
                                      ? SecondaryColor
                                      : Colors.grey.shade200,
                      border: (row + 1) % 3 == 0
                          ? Border(
                              bottom: const BorderSide(
                                  color: Colors.black, width: 2),
                              left: (col) % 3 == 0
                                  ? const BorderSide(
                                      color: Colors.black, width: 2)
                                  : const BorderSide(
                                      color: Color.fromARGB(255, 204, 204, 204),
                                      width: 1))
                          : (col) % 3 == 0
                              ? const Border(
                                  left:
                                      BorderSide(color: Colors.black, width: 2),
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 204, 204, 204),
                                      width: 1))
                              : Border.all(
                                  color:
                                      const Color.fromARGB(255, 204, 204, 204),
                                  width: 1),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        box.number == 0 ? "" : box.number.toString(),
                        style: LargeTextStyle,
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
