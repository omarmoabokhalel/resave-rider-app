import '../repositories/orders_repository.dart';

class UpdateOrderWeight {
  final OrdersRepository repo;

  UpdateOrderWeight(this.repo);

  Future<void> call(int orderId, List<Map<String, dynamic>> items) {
    return repo.updateWeight(orderId, items);
  }
}
