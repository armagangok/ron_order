import 'package:flutter/material.dart';

class CheckBoxProvider extends ChangeNotifier {
  bool value = false;

  void changeCheckBox(bool e) {
    value = e;
    notifyListeners();
  }
}
