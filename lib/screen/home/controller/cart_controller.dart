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
            print("main dish error");
            return false;
          } else {
            if (choosenFood.foodName == food.foodName) {
              print("ayni yemekten seçildi sayisini arttir");
              if (checkCart()) {
                food.amount++;
                notifyListeners();
              }
              return null;
            } else {
              print("farkli yemek sepete ekle");
              if (checkCart()) {
                choosenFood.amount++;
                foodCart.add(choosenFood);
                notifyListeners();
              }
              return null;
            }
          }
        }
        return null;
      }
      return null;
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
                  _foodCart.remove(foodInCart),
                }
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

  String getFoodAmount(List<FoodModel> foodCart, FoodModel food) {
    for (var element in foodCart) {
      if (element.foodName == food.foodName) {
        return element.amount.toString();
      }
    }

    return "0";
  }
}
