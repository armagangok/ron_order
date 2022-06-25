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
      if (checkIf1MainDish(choosenFood) == false) {
        return false;
      } else {
        checkIfSameFood(choosenFood)
            ? {
                if (checkCart())
                  {
                    choosenFood.amount++,
                    notifyListeners(),
                  }
              }
            : {
                if (checkCart())
                  {
                    choosenFood.amount++,
                    _foodCart.add(choosenFood),
                    notifyListeners(),
                  }
              };
      }
    }
    return null;
  }

  cancelFood(FoodModel food) {
    for (var foodInCart in _foodCart) {
      if (_foodCart.isNotEmpty) {
        (foodInCart.foodName == food.foodName)
            ? {
                foodInCart.amount--,
                {
                  if (foodInCart.amount == 0) _foodCart.remove(foodInCart),
                }
              }
            : {};
        notifyListeners();
      }
    }
  }

  bool checkIfSameFood(FoodModel choosenFood) {
    for (var foodInCart in _foodCart) {
      if (foodInCart.foodID == choosenFood.foodID) {
        return true;
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

  bool checkCart() {
    int allFood = 0;
    for (var element in _foodCart) {
      allFood += element.amount;
    }
    return (allFood < 3) ? true : false;
  }

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
}
