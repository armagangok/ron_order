import 'package:flutter/material.dart';


import '../models/category_model.dart';

class ChipViewmodel with ChangeNotifier {
  // static final ChipController _singleton = ChipController._();
  // factory ChipController() => _singleton;
  // ChipController._();

  final List<Category> categories = [
    
    Category(categoryName: "dishes", isSelected: true),
    Category(categoryName: "deserts", isSelected: false),
    Category(categoryName: "soups", isSelected: false),
    Category(categoryName: "salads", isSelected: false),
    Category(categoryName: "others", isSelected: false),
  ];

  final List<String> selectedCategoryList = ["dishes"];

  String get getChoosenCategory => selectedCategoryList[0];
  List<Category> get getCategories => categories;

  void changeCategory(String newCategory, bool value, index) {
    selectedCategoryList.clear();
    selectedCategoryList.add(newCategory);

    for (Category category in categories) {
      (category.isSelected == true) ? category.isSelected = false : {};
    }

    categories[index].isSelected = value;

    notifyListeners();
  }
}
