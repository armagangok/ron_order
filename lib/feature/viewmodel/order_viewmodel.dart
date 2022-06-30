import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../core/network/firestore/order_service/base_order_service.dart';
import '../../core/network/firestore/order_service/order_service.dart';
import '../models/order_model.dart';
import '../models/storage_model.dart';

class OrderViewmodel with ChangeNotifier implements BaserOrderService {
  final OrderService _orderService = OrderService();
  final _storage = FirebaseStorage.instance;
  OrderModel? orderModel;

  String downloadedUrl = "";
  List<OrderModel> orderList = [];
  List<OrderModel> activeOrderList = [];

  //

  @override
  Future<void> orderFood(OrderModel orderModel) async {
    (orderModel.activeOrderList.isNotEmpty)
        ? await _orderService.orderFood(orderModel)
        : {};
  }

  void clearOrderList() {
    orderList.clear();
    notifyListeners();
  }

  //

  @override
  Future<List<OrderModel>> fetchOrder() async {
    return await _orderService.fetchOrder();
  }

  Future<void> getOrderList() async {
    orderList = await fetchOrder();
  }

  //

  @override
  Future uploadFoodToStorage(StorogeFoodModel storageFoodModel) async {
    try {
      Reference ref = _storage.ref(
        "${storageFoodModel.foodModel.category}/${storageFoodModel.foodModel.foodName}.png",
      );

      TaskSnapshot uploadedFile = await ref.putFile(storageFoodModel.file);

      if (uploadedFile.state == TaskState.success) {
        downloadedUrl = await ref.getDownloadURL();

        storageFoodModel.foodModel.imageUrl = downloadedUrl;

        await _orderService.uploadFoodToStorage(storageFoodModel);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteAllOrders() async {
    await _orderService.deleteAllOrders();
    orderList.clear();
    notifyListeners();
  }

  @override
  Future<void> saveOrder(String uid, OrderModel orderModel) async {
    await _orderService.saveOrder(uid, orderModel);
  }

  @override
  Future<OrderModel> fetchActiveOrder(String uid) async {
    orderModel = await _orderService.fetchActiveOrder(uid);
    return orderModel!;
  }

  @override
  Future<void> deleteActiveOrder(String uid) async {
    await _orderService.deleteActiveOrder(uid);
    orderModel!.activeOrderList.clear();
    notifyListeners();
  }
}
