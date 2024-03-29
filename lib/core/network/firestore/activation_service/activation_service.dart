import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../feature/models/food_model.dart';
import 'base_activation_service.dart';


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
