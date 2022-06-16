import '../../../../../models/order_model.dart';
import '../../../../../models/storage_model.dart';

abstract class BaserOrderService {
  Future<void> orderFood(OrderModel foodModel);
  Future<List<OrderModel>> fetchOrder();
  Future uploadFoodToStorage(StorogeModel foodModel);
}
