import '../../../../feature/models/order_model.dart';
import '../../../../feature/models/storage_model.dart';

abstract class BaserOrderService {
  Future<void> orderFood(OrderModel foodModel);
  Future<List<OrderModel>> fetchOrder();
  Future uploadFoodToStorage(StorogeFoodModel foodModel);
  Future<void> deleteAllOrders();
  Future<void> saveOrder(String uid, OrderModel orderModel);
  Future<OrderModel> fetchActiveOrder(String uid);
  Future<void> deleteActiveOrder(String uid);
}
