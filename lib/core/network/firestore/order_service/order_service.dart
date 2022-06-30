// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ron_order/core/network/firebase/view-models/firebase_viewmodel.dart';

import '../../../../feature/models/order_model.dart';
import '../../../../feature/models/storage_model.dart';
import 'base_order_service.dart';

class OrderService implements BaserOrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final FirebaseVmodel _firebase = FirebaseVmodel();
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
    var collectionRef = FirebaseFirestore.instance.collection('orders');
    var snapshots = await collectionRef.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> saveOrder(String uid, OrderModel orderModel) async {
    await _firestore.collection('orders').doc(uid).set(orderModel.toMap());
  }

  @override
  Future<OrderModel> fetchActiveOrder(String uid) async {
    var snapshot = await _firestore.collection('orders').doc(uid).get();

    var order = OrderModel.fromMap(snapshot.data()!);
    return order;
  }

  @override

  Future<void> deleteActiveOrder(String uid) async {
    await _firestore.collection('orders').doc(uid).delete();
  }
}
