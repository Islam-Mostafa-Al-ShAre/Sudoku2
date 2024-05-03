// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/models/Box.dart';
import 'package:sudoku/utilties/data_structure/stack.dart';
import 'package:sudoku/utilties/my_constant/my_constants.dart';

class GameController extends GetxController {
  static GameController instance = Get.find();

  final List<List<Box>> _gridBoxs = [];
  List<List<int>> _gridBoxsAsNumber = [];
  final _time = 0.obs;
  int _selectedRow = -1;
  int _selectedCol = -1;
  int _mistakes = 0;
  Box? _currentSelectedBox;
  List<List<int>> preSolved = [];
  bool hintIsFount = false;
  get boxs => _gridBoxs;

  get time => _time.value;
  get mistakes => _mistakes;
  StackDataStructure<Box> lastPlayedStack = StackDataStructure<Box>();

  // use to update timer every one second
  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _time.value += 1;
    });
  }

  setBoxs(listOfListOfint) {
    _gridBoxsAsNumber = listOfListOfint;

    for (var slist in listOfListOfint) {
      List<Box> list = [];
      for (var number in slist) {
        Box box = Box(
            inHintStack: false,
            isSelected: false,
            hasRelationWithSelected: false,
            isWrong: false,
            number: number);
        list.add(box);
      }
      _gridBoxs.add(list);
    }

    // solve by sudoku algorthim
    preSolved = copyOfGridBoxsValues(boxs);
    solveSudoku(preSolved);
  }

  // to change row and col color and box(3*3) color and set current selected box
  onBoxClick(int row, int col) {
    _setCurrentSelectedBox(row, col);
    _selectedCol = col;
    _selectedRow = row;

    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        _gridBoxs[i][j].isSelected = false;
        _gridBoxs[i][j].hasRelationWithSelected = false;
        _gridBoxs[i][j].isWrong = false;
      }
    }

    for (var i = 0; i < 9; i++) {
      _gridBoxs[row][i].hasRelationWithSelected = true;
    }
    for (var i = 0; i < 9; i++) {
      _gridBoxs[i][col].hasRelationWithSelected = true;
    }

    int boxRow = (row ~/ 3) * 3;
    int boxCol = (col ~/ 3) * 3;
    for (var i = boxRow; i < boxRow + 3; i++) {
      for (var j = boxCol; j < boxCol + 3; j++) {
        _gridBoxs[i][j].hasRelationWithSelected = true;
      }
    }

    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (_currentSelectedBox != null) {
          if (getCurrentSelectedBox()!.number != 0) {
            if (getCurrentSelectedBox()!.number == _gridBoxs[i][j].number) {
              _gridBoxs[i][j].hasRelationWithSelected = true;
            }
          }
        }
      }
    }
    _gridBoxs[row][col].isSelected = true;
    update();
  }

  // to get current selected box
  Box? getCurrentSelectedBox() {
    return _currentSelectedBox;
  }

  // delete the number in the selected box
  deleteNumInSelectedBox() {
    //check first if there is selected box
    if (_currentSelectedBox != null) {
      lastPlayedStack.remove(_currentSelectedBox!);
      _currentSelectedBox!.number = 0;
      update();
    }
  }

  // to get back one step
  backOneStep() {
    if (!lastPlayedStack.isEmpty()) {
      lastPlayedStack.pop().number = 0;
      update();
    }
  }

  // check if the player played the correct number
  checkIfTheNumIsCorrect(int number) {
    //check if input number is the same of the number in presolved
    if (preSolved[_selectedRow][_selectedCol] == number) {
      _currentSelectedBox?.number = number;
      _gridBoxsAsNumber[_selectedRow][_selectedCol] = number;
      lastPlayedStack.push(_currentSelectedBox!);
    } else {
      //if not
      _currentSelectedBox?.isWrong = true;
      increaseMistakes();
    }
    update();
  }

  // use to increase player mistakes
  increaseMistakes() {
    _mistakes += 1;
  }

  getHint() {
    //vars
    hintIsFount = false;
    int startRow = -3;
    int startCol = 0;
    // loop until you find the solve
    do {
      if (startRow != 6) {
        startRow += 3;
      } else {
        startRow = 0;
        startCol += 3;
        if (startCol == 9) {
          return;
        }
      }

      List<List<int>> _3x3Boxsprobability = [];
      // get all empty box probabilty
      _3x3Boxsprobability = _helperGetHint(startRow, startCol);

      bool boxHasOnePorbability = false;
      int boxNumberWhichHasOneProbability = -1;
      //search for a box has has only one probabilty
      for (var i = 0; i < _3x3Boxsprobability.length; i++) {
        if (_3x3Boxsprobability[i].length == 1) {
          //if one box has one probability
          boxHasOnePorbability = true;
          boxNumberWhichHasOneProbability = i;
          break;
        }
      }
      //if there is a box has one porbabilty
      if (boxHasOnePorbability) {
        hintIsFount = true;
        //get that box location
        int boxRow = (boxNumberWhichHasOneProbability ~/ 3) + startRow;
        int boxCol = (boxNumberWhichHasOneProbability % 3) + startCol;
        //do some process
        _handleBoxHasOnePorbability(boxRow, boxCol);
      } else {
        //if there isn't a box has one probabilty find if there is a number has only one box to play in
        hintIsFount = _handleThereIsNoboxHasOneProbability(
            startRow, startCol, _3x3Boxsprobability);
      }
    } while (!hintIsFount);
  }

  _helperGetHint(int rowStart, int colStart) {
    List<List<int>> _3x3Boxsprobability = [];
    // loop on every box in 3x3
    for (int row = rowStart; row < rowStart + 3; row++) {
      for (var col = colStart; col < colStart + 3; col++) {
        List<int> helper = [];
        // check if the box is empty
        if (boxs[row][col].number == 0) {
          for (var number = 1; number <= 9; number++) {
            // check if the number is valild to this box
            if (isValidMove(_gridBoxsAsNumber, row, col, number)) {
              helper.add(number);
            }
          }
        }
        _3x3Boxsprobability.add(helper);
      }
    }
    return _3x3Boxsprobability;
  }

  _handleBoxHasOnePorbability(int row, int col) {
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    //to get every number can played in 3x3 box
    List<int> validNumberIn3x3 = [];
    for (var number = 1; number <= 9; number++) {
      bool numberIsValid = true;
      for (var i = startRow; i < startRow + 3; i++) {
        for (var j = startCol; j < startCol + 3; j++) {
          if (_gridBoxs[i][j].number == number) {
            numberIsValid = false;
          }
        }
      }
      //if number is valid
      if (numberIsValid) validNumberIn3x3.add(number);
    }
    List<int> validNumbers = [];
    validNumbers.addAll(validNumberIn3x3);
    List<Box> theReasonsBoxs = [];
    //get green boxs
    for (var i = 0; i < 9; i++) {
      if (validNumbers.contains(_gridBoxs[row][i].number)) {
        theReasonsBoxs.add(_gridBoxs[row][i]);
        validNumbers.remove(_gridBoxs[row][i].number);
      }
      if (validNumbers.contains(_gridBoxs[i][col].number)) {
        theReasonsBoxs.add(_gridBoxs[i][col]);
        validNumbers.remove(_gridBoxs[i][col].number);
      }
    }
    //chage boxs color based on state
    if (_currentSelectedBox != null) _currentSelectedBox!.isSelected = false;
    for (Box box in theReasonsBoxs) {
      box.inHintStack = true;
    }
    String text;
    if (theReasonsBoxs.isEmpty) {
      text =
          " You Must Feel Ashamed , Obviously You must play this number ${validNumberIn3x3.toString()} In Blue Box";
    } else {
      text =
          "You Can Play in Blue Box This Numbers ${validNumberIn3x3.toString()} But Becouse Of Green Boxs Values You Can Play Only ${validNumbers.toString()}";
    }
    onBoxClick(row, col);
    _currentSelectedBox?.isSelected = true;
    bottomSheet(text, theReasonsBoxs);
    update();
  }

  bool _handleThereIsNoboxHasOneProbability(
      int startRow, int startCol, List<List<int>> _3x3Boxsprobability) {
    Map<int, int> numbersCounts = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0
    };
    //to get how many time the number is repeated
    for (List box in _3x3Boxsprobability) {
      for (int number in box) {
        numbersCounts[number] = (numbersCounts[number]! + 1);
      }
    }
    int apperOneTimeOnly = -1;
    //get the number that repeated one time only, if Exist
    numbersCounts.forEach(
      (key, value) {
        if (value == 1) {
          apperOneTimeOnly = key;
          return;
        }
      },
    );

    if (apperOneTimeOnly != -1) {
      int boxNumberWhichHasApperOneTimeOnly = -1;
      // get the location of the box which contian that number which repeated  one time only
      //-------------------------------------------------------------
      for (var i = 0; i < 9; i++) {
        if (_3x3Boxsprobability[i].contains(apperOneTimeOnly)) {
          boxNumberWhichHasApperOneTimeOnly = i;

          break;
        }
      }

      int boxRow = (boxNumberWhichHasApperOneTimeOnly ~/ 3) + startRow;
      int boxCol = (boxNumberWhichHasApperOneTimeOnly % 3) + startCol;
      //---------------------------------------------------------------

      // chage boxs color based on state
      if (_currentSelectedBox != null) _currentSelectedBox!.isSelected = false;
      onBoxClick(boxRow, boxCol);
      //this function , get and show why this number repeated one thim
      _handleThereIsNoboxHasOneProbabilityhelaper(
          _3x3Boxsprobability, startRow, startCol, apperOneTimeOnly);

      return true;
    }

    return false;
  }

  _handleThereIsNoboxHasOneProbabilityhelaper(
      List<List<int>> _3x3Boxsprobability,
      int startRow,
      int startCol,
      int number) {
    List<Box> theReasonsBoxs = [];

    for (var i = 0; i < 9; i++) {
      int reasonRow = (i ~/ 3) + startRow;
      int reasonCol = (i % 3) + startCol;
      for (var j = 0; j < 9; j++) {
        if (number == _gridBoxs[reasonRow][j].number) {
          theReasonsBoxs.add(_gridBoxs[reasonRow][j]);
        }
        if (number == _gridBoxs[j][reasonCol].number) {
          theReasonsBoxs.add(_gridBoxs[j][reasonCol]);
        }
      }
    }
    for (Box box in theReasonsBoxs) {
      box.inHintStack = true;
    }
    String text =
        " The Only Box The $number Can Fit In is Blue Box Becouse Of Green Boxs Prevent Other 3X3Boxs holding $number";
    bottomSheet(text, theReasonsBoxs);
    update();
  }

  _setCurrentSelectedBox(int row, int col) {
    _currentSelectedBox = _gridBoxs[row][col];
  }

  bottomSheet(String text, List<Box> theResonsBoxs) {
    Get.dialog(
      barrierColor: const Color.fromARGB(0, 255, 255, 255),
      barrierDismissible: false,
      AlertDialog(
        insetPadding: const EdgeInsets.only(top: 550),
        title: const Text("Hint"),
        backgroundColor: const Color.fromARGB(107, 0, 0, 0),
        content: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
        actions: [
          InkWell(
            onTap: () {
              for (Box box in theResonsBoxs) {
                box.inHintStack = false;
              }

              update();
              Get.back();
            },
            child: Container(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<List<int>> copyOfGridBoxsValues(List<List<Box>> gridBoxs) {
  List<List<int>> copedList = [];

  for (var lists in gridBoxs) {
    List<int> list = [];
    for (var box in lists) {
      list.add(box.number);
    }

    copedList.add(list);
  }

  return copedList;
}

bool solveSudoku(List<List<int>> gridBoxsCopy) {
  const gridSize = 9;
  for (var row = 0; row < gridSize; row++) {
    for (var col = 0; col < gridSize; col++) {
      if (gridBoxsCopy[row][col] == 0) {
        for (var i = 1; i <= 9; i++) {
          if (isValidMove(gridBoxsCopy, row, col, i)) {
            gridBoxsCopy[row][col] = i;

            if (solveSudoku(gridBoxsCopy)) {
              return true;
            }
            //else
            gridBoxsCopy[row][col] = 0;
          }
        }
        return false; // no valid number found
      }
    }
  }

  return true; // grid is full
}

bool isValidMove(List<List<int>> gridBoxsCopy, int row, int col, int number) {
  const gridSize = 9;
  //check row and col
  for (var i = 0; i < gridSize; i++) {
    if (gridBoxsCopy[row][i] == number || gridBoxsCopy[i][col] == number) {
      return false;
    }
  }

  int startRow = (row ~/ 3) * 3;
  int startCol = (col ~/ 3) * 3;
  //check 3 by 3 square
  for (var i = startRow; i < startRow + 3; i++) {
    for (var j = startCol; j < startCol + 3; j++) {
      if (gridBoxsCopy[i][j] == number) {
        return false;
      }
    }
  }

  return true;
}
