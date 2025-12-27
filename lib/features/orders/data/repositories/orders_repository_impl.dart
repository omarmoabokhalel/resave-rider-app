import 'package:resave_rider/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';

import '../../domain/repositories/orders_repository.dart';


class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remote;

  OrdersRepositoryImpl(this.remote);

  @override
  Future<List<OrderModel>> getOrders() {
    return remote.getOrders();
  }

  @override
  Future<void> updateWeight(int orderId, List<Map<String, dynamic>> items) {
    return remote.updateWeight(orderId, items);
  }
}
