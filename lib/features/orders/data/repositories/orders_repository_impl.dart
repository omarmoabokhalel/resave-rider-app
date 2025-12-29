import '../../domain/repositories/orders_repository.dart';
import '../datasources/orders_remote_datasource.dart';
import '../models/orders_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remote;

  OrdersRepositoryImpl(this.remote);

  @override
  Future<List<OrderModel>> getOrders() => remote.getOrders();

  @override
  Future<void> acceptOrder(int orderId) =>
      remote.acceptOrder(orderId);

  @override
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  ) =>
      remote.updateWeight(orderId, items);
}
