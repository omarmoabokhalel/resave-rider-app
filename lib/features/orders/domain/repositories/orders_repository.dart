import '../../data/models/orders_model.dart';

abstract class OrdersRepository {
  Future<List<OrderModel>> getOrders();
  Future<void> acceptOrder(int orderId);
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  );
  Future<void> completeOrder(int orderId);
}

