import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'food_model.dart';

class OrderModel {
  List<FoodModel> activeOrderList;
  String orderer;
  String ordererId;
  String date;

  OrderModel({
    this.activeOrderList = const [],
    this.orderer = "",
    this.ordererId = "",
    this.date = "",
  });

  OrderModel copyWith({
    List<FoodModel>? activeOrderList,
    String? orderer,
    String? ordererId,
    String? date,
  }) {
    return OrderModel(
      activeOrderList: activeOrderList ?? this.activeOrderList,
      orderer: orderer ?? this.orderer,
      ordererId: ordererId ?? this.ordererId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activeOrderList': activeOrderList.map((x) => x.toMap()).toList(),
      'orderer': orderer,
      'ordererId': ordererId,
      'date': date,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      activeOrderList: List<FoodModel>.from(
          map['activeOrderList']?.map((x) => FoodModel.fromMap(x))),
      orderer: map['orderer'] ?? '',
      ordererId: map['ordererId'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(activeOrderList: $activeOrderList, orderer: $orderer, ordererId: $ordererId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        listEquals(other.activeOrderList, activeOrderList) &&
        other.orderer == orderer &&
        other.ordererId == ordererId &&
        other.date == date;
  }

  @override
  int get hashCode {
    return activeOrderList.hashCode ^
        orderer.hashCode ^
        ordererId.hashCode ^
        date.hashCode;
  }
}
