import '../repositories/orders_repository.dart';

class UpdateWeight {
  final OrdersRepository repository;

  UpdateWeight(this.repository);

  Future<void> call(
    int orderId,
    List<Map<String, dynamic>> items,
  ) {
    return repository.updateWeight(orderId, items);
  }
}
