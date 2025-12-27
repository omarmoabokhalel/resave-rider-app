import 'package:resave_rider/features/orders/data/models/orders_model.dart';

import '../../../../core/api/api_service.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> updateWeight(int orderId, List<Map<String, dynamic>> items);
}

class OrdersRemoteDataSourceImpl
    implements OrdersRemoteDataSource {
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
  Future<void> updateWeight(
      int orderId, List<Map<String, dynamic>> items) async {
    await api.dio.post(
      '/rider/order/$orderId/update-weight',
      data: {'items': items},
    );
  }
}
