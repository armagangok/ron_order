import 'package:flutter/material.dart';

import '../models/category_model.dart';

class ChipController with ChangeNotifier {
  static final ChipController _singleton = ChipController._();
  factory ChipController() => _singleton;
  ChipController._();

  final List<Category> categories = [
    Category(categoryName: "dishes", isSelected: true),
    Category(categoryName: "sub dishes", isSelected: false),
    Category(categoryName: "deserts", isSelected: false),
    Category(categoryName: "soups", isSelected: false),
    Category(categoryName: "salads", isSelected: false),
    Category(categoryName: "others", isSelected: false),
  ];

  final List<String> choosenCategoryList = ["dishes"];

  String get chosenCategory => choosenCategoryList[0];
  List<Category> get getCategories => categories;

  void changeCategory(String newCategory, bool value, int index) {
    choosenCategoryList.clear();
    choosenCategoryList.add(newCategory);

    for (Category category in categories) {
      (category.isSelected == true)
          ? category.isSelected = false
          : {category.isSelected == true};
    }

    categories[index].isSelected = value;
    notifyListeners();
  }
}
