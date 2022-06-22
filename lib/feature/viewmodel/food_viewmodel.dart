import 'package:flutter/material.dart';
import 'package:ron_order/core/network/firebase/view-models/firebase_viewmodel.dart';

import '../../core/network/firestore/food_service/base_food_service.dart';
import '../../core/network/firestore/food_service/food_service.dart';
import '../models/food_model.dart';

class FoodViewmodel with ChangeNotifier implements BaseFoodService {
  final FoodService _foodService = FoodService();
  final FirebaseVmodel _firebase = FirebaseVmodel();

  //
  //

  Future<List<FoodModel>> fetchAllFood() async {
    final List<FoodModel> shuffledFoodList = [];

    for (var element in await fetchFoodByCategory("deserts")) {
      shuffledFoodList.add(element);
    }

    for (var element in await fetchFoodByCategory("dishes")) {
      shuffledFoodList.add(element);
    }

    for (var element in await fetchFoodByCategory("others")) {
      shuffledFoodList.add(element);
    }

    for (var element in await fetchFoodByCategory("soups")) {
      shuffledFoodList.add(element);
    }

    for (var element in await fetchFoodByCategory("salads")) {
      shuffledFoodList.add(element);
    }

    for (var i = 0; i < 5; i++) {
      shuffledFoodList.shuffle();
    }

    return shuffledFoodList;
  }

  //
  //

  @override
  Future<List<FoodModel>> fetchFoodByCategory(String category) async {
    List<FoodModel> foodList = [];
    var foodListFromService = await _foodService.fetchFoodByCategory(category);

    var user = await _firebase.currentUser();
    if (user!.email == "admin@admin.com") {
      return foodListFromService;
    } else {
      for (var food in foodListFromService) {
        (food.isActive == true) ? foodList.add(food) : {};
      }
      return foodList;
    }
  }

  Future<List<FoodModel>> fetchFoodForAdminScreen(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    return foodListFromService;
  }

  @override
  Future<void> deleteFood(FoodModel food) async {
    await _foodService.deleteFood(food);
    notifyListeners();
  }
}
