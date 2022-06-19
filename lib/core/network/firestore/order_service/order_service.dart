// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../feature/models/order_model.dart';
import '../../../../feature/models/storage_model.dart';
import 'base_order_service.dart';

class OrderService implements BaserOrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  String downloadedUrl = "";

  //

  @override
  Future<void> orderFood(OrderModel orderModel) async {
    try {
      await _firestore
          .collection("orders")
          .doc(orderModel.ordererId)
          .set(orderModel.toMap());
    } catch (e) {
      print(e);
    }
  }

  //

  @override
  Future<List<OrderModel>> fetchOrder() async {
    final List<OrderModel> orders = [];

    try {
      var orderSnapshot = await _firestore.collection("orders").get();

      for (var orderMap in orderSnapshot.docs) {
        orders.add(OrderModel.fromMap(orderMap.data()));
      }
      return orders;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //

  @override
  Future uploadFoodToStorage(StorogeFoodModel storageModel) async {
    try {
      await adFood(storageModel);

      Reference ref = _storage.ref(
        "${storageModel.foodModel.category}/${storageModel.foodModel.foodName}.png",
      );

      TaskSnapshot uploadedFile = await ref.putFile(storageModel.file);

      if (uploadedFile.state == TaskState.success) {
        downloadedUrl = await ref.getDownloadURL();
        print(downloadedUrl);

        storageModel.foodModel.imageUrl = downloadedUrl;
      }
    } catch (e) {
      print(e);
    }
  }

  //

  Future adFood(StorogeFoodModel storageModel) async {
    try {
      await _firestore
          .collection(storageModel.foodModel.category)
          .doc(storageModel.foodModel.foodID)
          .set(storageModel.foodModel.toMap());
    } catch (e) {
      print(e);
    }
  }

  //

  @override
  Future<void> deleteAllOrders() async {
    _firestore.collection('orders').get().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      },
    );
  }
}
