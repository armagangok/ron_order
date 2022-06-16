import '../../../../../global/models/food_model.dart';

abstract class BaseFoodService {
  // Future<List<FoodModel>> fetchDesert();
  // Future<List<FoodModel>> fetchSoup();
  // Future<List<FoodModel>> fetchDishes();
  // Future<List<FoodModel>> fetchSalad();
  // Future<List<FoodModel>> fetchOther();
  Future<List<FoodModel>> fetchFoodByCategory(String category);
}
