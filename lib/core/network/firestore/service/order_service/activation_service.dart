import 'package:cloud_firestore/cloud_firestore.dart';

import './base/base_activation_service.dart';
import '../../../../models/food_model.dart';

class ActivationService implements BaseActivationService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future updateFood(FoodModel food) async {
    await firestore
        .collection(food.category)
        .doc(food.foodID)
        .set(food.toMap());
  }
}
