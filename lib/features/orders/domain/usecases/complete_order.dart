import 'package:resave_rider/features/orders/domain/repositories/orders_repository.dart';
class CompleteOrder {
  final OrdersRepository repository;

  CompleteOrder(this.repository);

  Future<void> call(int orderId) {
    return repository.completeOrder(orderId);
  }
}