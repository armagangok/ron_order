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

  String _choosenCategory = "dishes";
  String get chosenCategory => _choosenCategory;
  List<Category> get getCategories => categories;

  void changeCategory(String newCategory, bool value, int index) {
    chosenCategory == newCategory
        ? {}
        : {
            _choosenCategory = newCategory,
            for (Category category in categories)
              {
                (category.isSelected == true)
                    ? category.isSelected = false
                    : {},
              },
            categories[index].isSelected = value,
            notifyListeners(),
          };
  }
}
