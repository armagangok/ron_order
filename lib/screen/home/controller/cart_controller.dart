// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../feature/models/food_model.dart';

class CartController with ChangeNotifier {
  final List<FoodModel> _foodCart = [];

  List<FoodModel> get foodCart => _foodCart;
  int get cartLength => _foodCart.length;

  bool addFoodToCart(FoodModel choosenFood) {
    int holder = 0;
    if (_foodCart.isEmpty) {
      checkFoodList() ? _foodCart.add(choosenFood) : {};
      notifyListeners();
      return true;
    } else if (_foodCart.isNotEmpty) {
      for (var foodInCart in _foodCart) {
        if (choosenFood.category == foodInCart.category) holder++;
      }

      if (holder == 0) {
        checkFoodList()
            ? {
                _foodCart.add(choosenFood),
                notifyListeners(),
              }
            : {};
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  removeFoodFromCart(FoodModel food) {
    for (var foodInCart in _foodCart) {
      if (_foodCart.isNotEmpty) {
        (foodInCart.foodName == food.foodName)
            ? _foodCart.remove(foodInCart)
            : {};
        notifyListeners();
      }
    }
  }

  bool checkFoodList() {
    return (_foodCart.length < 3) ? true : false;
  }

  bool isSelected(FoodModel selectedFood) {
    for (var food in _foodCart) {
      if (food.foodName == selectedFood.foodName) {
        return true;
      }
    }
    return false;
  }
}
