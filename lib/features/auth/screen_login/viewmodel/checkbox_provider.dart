import 'package:flutter/material.dart';

class CheckBoxController extends ChangeNotifier {
  bool value = false;

  void changeCheckBox(bool e) {
    value = e;
    notifyListeners();
  }
}
