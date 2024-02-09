import 'package:flutter/material.dart';

class DropDownController with ChangeNotifier {
  String dropDownValue = "dishes";

  List<String> categories = [
    "dishes",
    "sub dishes",
    "deserts",
    "soups",
    "salads",
    "others",
  ];

  void changeCategory(String category) {
    dropDownValue = category;
    notifyListeners();
  }
}
