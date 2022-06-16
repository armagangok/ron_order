import 'package:flutter/material.dart';

class DropDownProvider with ChangeNotifier {
  String dropDownValue = "dishes";

  List<String> categories = [
    "dishes",
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
