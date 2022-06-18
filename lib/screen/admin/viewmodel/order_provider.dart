import 'package:ron_order/feature/models/order_model.dart';

class OrderListProvider {
  List<OrderModel> _orders = [];

  get getOrderList => _orders;
  set setOrderList(List<OrderModel> orderList) => _orders = orderList;
}
