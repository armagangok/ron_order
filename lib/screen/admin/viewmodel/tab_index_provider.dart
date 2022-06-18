import 'package:flutter/material.dart';

class TabIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
