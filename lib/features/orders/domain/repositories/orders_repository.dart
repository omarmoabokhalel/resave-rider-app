
import 'package:resave_rider/features/orders/data/models/orders_model.dart';

abstract class OrdersRepository {
  Future<List<OrderModel>> getOrders();
  Future<void> updateWeight(int orderId, List<Map<String, dynamic>> items);
}
