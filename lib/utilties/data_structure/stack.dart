class StackDataStructure<T> {
  final List<T> _stack = [];

  void push(T box) {
    _stack.add(box);
  }

  T pop() {
    if (_stack.isEmpty) {
      throw StateError("No elements in the Stack");
    } else {
      T lastElement = _stack.last;
      _stack.removeLast();
      return lastElement;
    }
  }

  T top() {
    if (_stack.isEmpty) {
      throw StateError("No elements in the Stack");
    } else {
      return _stack.last;
    }
  }

  bool isEmpty() {
    return _stack.isEmpty;
  }

  void remove(T box) {
    _stack.remove(box);
  }

  @override
  String toString() => _stack.toString();
}
