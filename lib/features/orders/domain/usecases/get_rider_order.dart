import 'package:resave_rider/features/orders/data/models/orders_model.dart';

import '../repositories/orders_repository.dart';

class GetRiderOrders {
  final OrdersRepository repo;

  GetRiderOrders(this.repo);

  Future<List<OrderModel>> call() {
    return repo.getOrders();
  }
}
