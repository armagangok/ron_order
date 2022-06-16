import 'package:flutter/material.dart';


import '../../../core/network/firestore/service/order_service/activation_service.dart';
import '../../../core/network/firestore/service/order_service/base/base_activation_service.dart';
import '../../../global/models/food_model.dart';

class ActivationViewmodel with ChangeNotifier implements BaseActivationService {
  final ActivationService _activationService = ActivationService();

  @override
  Future updateFood(FoodModel food) async {
    await _activationService.updateFood(food);
    notifyListeners();
  }

  Future inactivate(FoodModel food) async {
    food.isActive = false;
    await updateFood(food);
  }

  Future activate(FoodModel food) async {
    food.isActive = true;
    await updateFood(food);
  }
}
