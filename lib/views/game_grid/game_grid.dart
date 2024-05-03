import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/controllers/game_controllers.dart';
import 'package:sudoku/controllers/home_controller.dart';
import 'package:sudoku/utilties/sudoku_solver_generator/sudoku_generator_base.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';
import 'package:sudoku/views/game_grid/widgets/info_bar.dart';
import 'package:sudoku/views/game_grid/widgets/inputs_view.dart';
import 'package:sudoku/views/game_grid/widgets/the_grid.dart';
import 'package:sudoku/views/game_grid/widgets/tools_bar.dart';
import 'package:sudoku/views/widgets/game_app_bar.dart';
import 'package:sudoku/views/widgets/vertical_horizontal_spance.dart';

class GameGrid extends StatefulWidget {
  const GameGrid({super.key});

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  GameController gameController = Get.put(GameController());
  final HomeController _homeController = Get.find();
  late List list = [];
  //stopwatch

  @override
  void initState() {
    super.initState();
    gameController.startTimer();

    var s = SudokuGenerator(
        emptySquares: _homeController.numberOfEmptySquare(),
        uniqueSolution: true);
    gameController.setBoxs(s.newSudoku);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gameAppBar("Sudoku Ai"),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: backgroundColor,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const VerticalSpace(20),
              //info bar like timer and mistakes and score
              InfoBar(),
              const VerticalSpace(40),
              //the number gird it self
              TheGrid(),
              const VerticalSpace(40),
              //tool bar like hint, delete, back
              ToolsBar(),
              const VerticalSpace(40),
              //user input
              const InputsView()
            ],
          )),
    );
  }
}
