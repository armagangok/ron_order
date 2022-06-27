// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

import '../../../feature/models/food_model.dart';

class CartController with ChangeNotifier {
  final List<FoodModel> _foodCart = [];

  List<FoodModel> get foodCart => _foodCart;
  int get cartLength => _foodCart.length;

  dynamic addFood(FoodModel choosenFood) {
    if (foodCart.isEmpty) {
      choosenFood.amount++;
      _foodCart.add(choosenFood);
      notifyListeners();
    } else {
      if (checkIf1MainDish(choosenFood) == false) {
        return false;
      } else {
        if (checkIfSameFood(choosenFood) == false) {
          if (checkCart()) {
            choosenFood.amount++;
            _foodCart.add(choosenFood);
            notifyListeners();
            return true;
          } else {
            return null;
          }
        } else {
          if (checkCart()) {
            checkIfSameFood(choosenFood).amount++;
            notifyListeners();
            return true;
          } else {
            return null;
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
                foodInCart.amount--,
                if (foodInCart.amount == 0) _foodCart.remove(foodInCart),
              }
            : {};
        notifyListeners();
      }
    }
  }

  dynamic checkIfSameFood(FoodModel choosenFood) {
    for (var foodInCart in _foodCart) {
      if (foodInCart.foodID == choosenFood.foodID) {
        return foodInCart;
      }
    }
    return false;
  }

  bool checkIf1MainDish(FoodModel choosenFood) {
    int counter = 0;
    for (var foodInCart in _foodCart) {
      if (foodInCart.category == "dishes" && choosenFood.category == "dishes") {
        counter++;
      }
    }

    return (counter == 0) ? true : false;
  }

  bool checkCart() => (getTotalFood() < 3) ? true : false;

  bool isSelected(FoodModel selectedFood) {
    for (var food in _foodCart) {
      if (food.foodName == selectedFood.foodName) {
        return true;
      }
    }
    return false;
  }

  String getFoodAmount(List<FoodModel> foodCart, FoodModel food) {
    for (var element in foodCart) {
      if (element.foodName == food.foodName) {
        return element.amount.toString();
      }
    }
    return "0";
  }

  int getTotalFood() {
    int total = 0;
    for (var element in _foodCart) {
      total += element.amount;
    }
    return total;
  }
}
