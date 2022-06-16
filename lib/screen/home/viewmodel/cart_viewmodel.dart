// ignore_for_file: avoid_print

import 'package:flutter/material.dart';


import '../../../global/models/food_model.dart';

class CartViewmodel with ChangeNotifier {
  final List<FoodModel> _foodCart = [];

  List<FoodModel> get foodCart => _foodCart;
  int get cartLength => _foodCart.length;

  addFoodToCart(FoodModel choosenFood) {
    if (_foodCart.isEmpty) {
      print("empty");
      checkFoodList() ? _foodCart.add(choosenFood) : {};
      notifyListeners();
    } else {
      print("not empty");

      for (var foodInCart in _foodCart) {
        if (foodInCart.category == choosenFood.category) {
          break;
        } else if (foodInCart.category != choosenFood.category) {
          checkFoodList() ? _foodCart.add(choosenFood) : {};
          notifyListeners();
          break;
        }
        break;
      }
    }
  } 

  removeFoodFromCart(FoodModel food) {
    for (var element in _foodCart) {
      if (_foodCart.isNotEmpty) {
        (element.foodName == food.foodName) ? _foodCart.remove(element) : {};
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
