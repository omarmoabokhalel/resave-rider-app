import '../../domain/repositories/orders_repository.dart';
class AcceptOrder {
  final OrdersRepository repository;

  AcceptOrder(this.repository);

  Future<void> call(int orderId) {
    return repository.acceptOrder(orderId);
  }
}