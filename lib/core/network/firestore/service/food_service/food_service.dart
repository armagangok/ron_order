import 'package:cloud_firestore/cloud_firestore.dart';

import './base_food_service.dart';
import '../../../../models/food_model.dart';

class FoodService implements BaseFoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<FoodModel>> fetchFoodByCategory(String category) async {
    final List<FoodModel> foodList = [];

    var orderSnapshot = await _firestore.collection(category).get();

    for (var orderMap in orderSnapshot.docs) {
      var food = FoodModel.fromMap(orderMap.data());
      foodList.add(food);
    }
    return foodList;
  }
}
