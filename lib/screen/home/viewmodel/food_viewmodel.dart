import 'package:ron_order/core/network/firebase/view-models/firebase_viewmodel.dart';

import '../../../core/models/food_model.dart';
import '../../../core/network/firestore/service/food_service/base_food_service.dart';
import '../../../core/network/firestore/service/food_service/food_service.dart';

class FoodProvider implements BaseFoodService {
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

    shuffledFoodList.shuffle();
    shuffledFoodList.shuffle();
    shuffledFoodList.shuffle();
    shuffledFoodList.shuffle();

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
}
