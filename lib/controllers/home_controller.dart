import 'package:get/get.dart';

class HomeController extends GetxController {
  String _gameDiffculity = "";

  void setGameDiffculity(String diffuclity) {
    _gameDiffculity = diffuclity;
  }

  int numberOfEmptySquare() {
    if (_gameDiffculity == "Easy") {
      return 18;
    } else if (_gameDiffculity == "Normal") {
      return 36;
    } else {
      return 54;
    }
  }
}
