// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../../feature/models/food_model.dart';

class CartController with ChangeNotifier {
  final List<FoodModel> _foodCart = [];

  List<FoodModel> get foodCart => _foodCart;
  int get cartLength => _foodCart.length;

  bool? addFood(FoodModel choosenFood) {
    if (foodCart.isEmpty) {
      choosenFood.amount++;
      _foodCart.add(choosenFood);
      notifyListeners();
    } else {
      if (checkCart()) {
        for (var food in foodCart) {
          if (food.category == "dishes" && choosenFood.category == "dishes") {
            print("ana yemek zaten eklendi.");
            false;
          } else {
            if (checkCart()) {
              foodCart.add(choosenFood);
            }
            for (var element in foodCart) {
              if (element.foodName == choosenFood.foodName) {
                element.amount++;
                break;
              }
            }
            notifyListeners();
          }
        }
      }
    }
    return true;
  }

  cancelFood(FoodModel food) {
    for (var foodInCart in _foodCart) {
      if (_foodCart.isNotEmpty) {
        (foodInCart.foodName == food.foodName)
            ? {
                _foodCart.remove(foodInCart),
                foodInCart.amount--,
              }
            : {};
        notifyListeners();
      }
    }
  }

  bool checkCart() {
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



  // if (holder == 0) {
  //           if (checkFoodList()) _foodCart.add(choosenFood);
  //           notifyListeners();
  //           return true;
  //         } else {
  //           if (checkFoodList()) {
  //             _foodCart.add(choosenFood);
  //             notifyListeners();
  //             return true;
  //           }
  //           return false;
  //         }

  