import 'package:flutter/foundation.dart';

class RootScreenIndexProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  void setIndex(int newIndex) {
    if (newIndex == -1) {
      _index = 0;
    } else {
      _index = newIndex;
    }
    notifyListeners();
  }
}
