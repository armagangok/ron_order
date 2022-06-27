import 'package:flutter/material.dart';

import '../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../core/network/firestore/food_service/food_service.dart';
import '../models/food_model.dart';

class FoodViewmodel with ChangeNotifier {
  static final FoodViewmodel _singleton = FoodViewmodel._internal();
  factory FoodViewmodel() => _singleton;
  FoodViewmodel._internal();

  final FoodService _foodService = FoodService();
  final FirebaseVmodel _firebase = FirebaseVmodel();

  Map<String, List<FoodModel>> all = {
    "dishes": [],
    "sub dish": [],
    "deserts": [],
    "soups": [],
    "salads": [],
    "others": [],
  };

  Future<List<FoodModel>> fetchFoodForUserScreen(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    List<FoodModel> foodList = [];

    for (var food in foodListFromService) {
      (food.isActive == true) ? foodList.add(food) : {};
    }

    return foodList;
  }

  Future<List<FoodModel>> fetchFoodForAdminScreen(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    return foodListFromService;
  }

  Future<void> deleteFood(FoodModel food) async {
    await _foodService
        .deleteFood(food)
        .whenComplete(() => all[food.category]!.remove(food));
    notifyListeners();
  }

  Future<void> getAllFood() async {
    fetchFoodForAdminScreen("dishes").then((dishes) => all["dishes"] = dishes);

    fetchFoodForAdminScreen("sub dishes")
        .then((subDishes) => all["sub dishes"] = subDishes);

    fetchFoodForAdminScreen("deserts")
        .then((deserts) => all["deserts"] = deserts);

    fetchFoodForAdminScreen("soups").then((soups) => all["soups"] = soups);

    fetchFoodForAdminScreen("salads").then((salads) => all["salads"] = salads);

    fetchFoodForAdminScreen("others").then((others) => all["others"] = others);
  }
}

// Future<List<FoodModel>> fetchAllFood() async {
//   final List<FoodModel> shuffledFoodList = [];

//   for (var element in await fetchFoodByCategory("deserts")) {
//     shuffledFoodList.add(element);
//   }

//   for (var element in await fetchFoodByCategory("dishes")) {
//     shuffledFoodList.add(element);
//   }

//   for (var element in await fetchFoodByCategory("others")) {
//     shuffledFoodList.add(element);
//   }

//   for (var element in await fetchFoodByCategory("soups")) {
//     shuffledFoodList.add(element);
//   }

//   for (var element in await fetchFoodByCategory("salads")) {
//     shuffledFoodList.add(element);
//   }

//   for (var i = 0; i < 5; i++) {
//     shuffledFoodList.shuffle();
//   }

//   return shuffledFoodList;
// }

