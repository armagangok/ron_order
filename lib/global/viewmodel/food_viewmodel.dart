import 'package:flutter/material.dart';

import '../../core/network/firestore/food_service/food_service.dart';
import '../models/food_model.dart';

class FoodViewmodel with ChangeNotifier {
  static final FoodViewmodel _singleton = FoodViewmodel._internal();
  factory FoodViewmodel() => _singleton;
  FoodViewmodel._internal();

  final FoodService _foodService = FoodService();

  Map<String, List<FoodModel>> fetchedFoodList = {
    "dishes": [],
    "sub dish": [],
    "deserts": [],
    "soups": [],
    "salads": [],
    "others": [],
  };

  // Map<String, List<FoodModel>> allUser = {
  //   "dishes": [],
  //   "sub dish": [],
  //   "deserts": [],
  //   "soups": [],
  //   "salads": [],
  //   "others": [],
  // };

  Future<List<FoodModel>> fetchFoodForUser(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    List<FoodModel> foodList = [];

    for (var food in foodListFromService) {
      (food.isActive == true) ? foodList.add(food) : {};
    }

    return foodList;
  }

  Future<List<FoodModel>> fetchFoodForAdmin(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    return foodListFromService;
  }

  Future<List<FoodModel>> fetchFoodList(String category) async {
    var foodListFromService = await _foodService.fetchFoodByCategory(category);
    return foodListFromService;
  }

  Future<void> deleteFood(FoodModel food) async {
    await _foodService
        .deleteFood(food)
        .whenComplete(() => fetchedFoodList[food.category]!.remove(food));
    notifyListeners();
  }

  Future<void> getAllFood({bool? forAdmin}) async {
    final List<FoodModel> dishes = forAdmin!
        ? await fetchFoodForAdmin("dishes")
        : await fetchFoodForUser("dishes");
    fetchedFoodList["dishes"] = dishes;

    final List<FoodModel> subDishes = forAdmin
        ? await fetchFoodForAdmin("sub dishes")
        : await fetchFoodForUser("sub dishes");
    fetchedFoodList["sub dishes"] = subDishes;

    final List<FoodModel> deserts = forAdmin
        ? await fetchFoodForAdmin("deserts")
        : await fetchFoodForUser("deserts");
    fetchedFoodList["deserts"] = deserts;

    final List<FoodModel> soups = forAdmin
        ? await fetchFoodForAdmin("soups")
        : await fetchFoodForUser("soups");
    fetchedFoodList["soups"] = soups;

    final List<FoodModel> salads = forAdmin
        ? await fetchFoodForAdmin("salads")
        : await fetchFoodForUser("salads");
    fetchedFoodList["salads"] = salads;

    final List<FoodModel> others = forAdmin
        ? await fetchFoodForAdmin("others")
        : await fetchFoodForUser("others");
    fetchedFoodList["others"] = others;

    notifyListeners();
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

