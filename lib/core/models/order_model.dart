import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'food_model.dart';

class OrderModel {
  List<FoodModel> orderList = [];
  String orderer = "";
  String ordererId = "";
  OrderModel({
    required this.orderList,
    required this.orderer,
    required this.ordererId,
  });

  OrderModel copyWith({
    List<FoodModel>? foodList,
    String? orderer,
    String? ordererId,
  }) {
    return OrderModel(
      orderList: foodList ?? orderList,
      orderer: orderer ?? this.orderer,
      ordererId: ordererId ?? this.ordererId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foodList': orderList.map((x) => x.toMap()).toList(),
      'orderer': orderer,
      'ordererId': ordererId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderList: List<FoodModel>.from(
          map['foodList']?.map((x) => FoodModel.fromMap(x))),
      orderer: map['orderer'] ?? '',
      ordererId: map['ordererId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderModel(foodList: $orderList, orderer: $orderer, ordererId: $ordererId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        listEquals(other.orderList, orderList) &&
        other.orderer == orderer &&
        other.ordererId == ordererId;
  }

  @override
  int get hashCode =>
      orderList.hashCode ^ orderer.hashCode ^ ordererId.hashCode;
}
