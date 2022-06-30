import 'package:flutter/material.dart';

import '../../../feature/models/food_model.dart';

class ActiveOrderController with ChangeNotifier {
  final List<FoodModel> _activeOrderCart = [];

  List<FoodModel> get foodCart => _activeOrderCart;
  int get cartLength => _activeOrderCart.length;

  dynamic addFood(FoodModel choosenFood) {
    if (foodCart.isEmpty) {
      choosenFood.amount++;
      _activeOrderCart.add(choosenFood);
      notifyListeners();
    } else {
      if (checkIf1MainDish(choosenFood) == false) {
        return false;
      } else {
        if (checkIfSameFood(choosenFood) == false) {
          if (checkCart()) {
            choosenFood.amount++;
            _activeOrderCart.add(choosenFood);
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
    for (var foodInCart in _activeOrderCart) {
      if (_activeOrderCart.isNotEmpty) {
        (foodInCart.foodName == food.foodName)
            ? {
                foodInCart.amount--,
                if (foodInCart.amount == 0) _activeOrderCart.remove(foodInCart),
              }
            : {};
        notifyListeners();
      }
    }
  }

  dynamic checkIfSameFood(FoodModel choosenFood) {
    for (var foodInCart in _activeOrderCart) {
      if (foodInCart.foodID == choosenFood.foodID) {
        return foodInCart;
      }
    }
    return false;
  }

  bool checkIf1MainDish(FoodModel choosenFood) {
    int counter = 0;
    for (var foodInCart in _activeOrderCart) {
      if (foodInCart.category == "dishes" && choosenFood.category == "dishes") {
        counter++;
      }
    }

    return (counter == 0) ? true : false;
  }

  bool checkCart() => (getTotalFood() < 3) ? true : false;

  bool isSelected(FoodModel selectedFood) {
    for (var food in _activeOrderCart) {
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
    for (var element in _activeOrderCart) {
      total += element.amount;
    }
    return total;
  }

  void clearCart() {
    foodCart.clear();
    notifyListeners();
  }
}
