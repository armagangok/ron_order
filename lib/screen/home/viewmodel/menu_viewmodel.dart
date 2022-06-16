import 'package:flutter/material.dart';

class MenuViewmodel with ChangeNotifier {
  bool isTview = true;

  void changeMenuType() {
    isTview = !isTview;
    notifyListeners();
  }
}
