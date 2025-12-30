import '../repositories/orders_repository.dart';
import '../../data/models/orders_model.dart';

class GetOrders {
  final OrdersRepository repository;

  GetOrders(this.repository);

  Future<List<OrderModel>> call() {
    return repository.getOrders();
  }
}
