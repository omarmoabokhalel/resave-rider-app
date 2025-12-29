import 'package:resave_rider/features/orders/domain/usecases/complete_order.dart' as repository;

Future<void> completeOrder(int orderId) {
  return repository.completeOrder(orderId);
}
