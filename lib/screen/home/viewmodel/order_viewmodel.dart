// ignore_for_file: avoid_print

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/network/firestore/service/order_service/order_service.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/storage_model.dart';
import '../../../core/network/firestore/service/order_service/base/base_order_service.dart';

class OrderViewmodel implements BaserOrderService {
  final OrderService _orderService = OrderService();
  final _storage = FirebaseStorage.instance;

  String downloadedUrl = "";

  //

  @override
  Future<void> orderFood(OrderModel orderModel) async {
    (orderModel.orderList.isNotEmpty)
        ? await _orderService.orderFood(orderModel)
        : {};
  }

  //

  @override
  Future<List<OrderModel>> fetchOrder() async {
    return await _orderService.fetchOrder();
  }

  //

  @override
  Future uploadFoodToStorage(StorogeModel storageModel) async {
    try {
      Reference ref = _storage.ref(
        "${storageModel.foodModel.category}/${storageModel.foodModel.foodName}.png",
      );

      TaskSnapshot uploadedFile = await ref.putFile(storageModel.file);

      if (uploadedFile.state == TaskState.success) {
        downloadedUrl = await ref.getDownloadURL();
        print(downloadedUrl);

        storageModel.foodModel.imageUrl = downloadedUrl;

        await _orderService.uploadFoodToStorage(storageModel);
      }
    } catch (e) {
      print(e);
    }
  }

  Future adFood(StorogeModel foodModel) async {
    await _orderService.adFood(foodModel);
  }
}
