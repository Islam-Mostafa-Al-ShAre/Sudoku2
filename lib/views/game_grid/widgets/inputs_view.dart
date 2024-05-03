import 'package:flutter/material.dart';
import 'package:sudoku/views/game_grid/widgets/num_input.dart';

class InputsView extends StatelessWidget {
  const InputsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumInput(number: 1),
        NumInput(number: 2),
        NumInput(number: 3),
        NumInput(number: 4),
        NumInput(number: 5),
        NumInput(number: 6),
        NumInput(number: 7),
        NumInput(number: 8),
        NumInput(number: 9),
      ],
    );
  }
}
