// square data sctruture
class Box {
  int number;
  bool inHintStack;
  bool isSelected;
  bool hasRelationWithSelected;
  bool isWrong;

  Box(
      {required this.inHintStack,
      required this.isSelected,
      required this.hasRelationWithSelected,
      required this.number,
      required this.isWrong});
}
