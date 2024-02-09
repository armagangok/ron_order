import 'package:flutter/material.dart';

class TabBarController with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
