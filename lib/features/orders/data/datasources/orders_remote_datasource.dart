import 'package:resave_rider/core/api/api_service.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> acceptOrder(int orderId);
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  );
  Future<void> completeOrder(int orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiService api;

  OrdersRemoteDataSourceImpl(this.api);

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await api.dio.get('/rider/orders');
    return (response.data as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> acceptOrder(int orderId) async {
    await api.dio.post('/rider/order/$orderId/accept');
  }

  @override
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  ) async {
    await api.dio.post(
      '/rider/order/$orderId/update-weight',
      data: {'items': items},
    );
  }
  @override
  Future<void> completeOrder(int orderId) async {
  await api.dio.post('/rider/order/$orderId/complete');
}

}


