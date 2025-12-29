abstract class OrdersEvent {}

class LoadOrdersEvent extends OrdersEvent {}

class UpdateWeightEvent extends OrdersEvent {
  final int orderId;
  final List<Map<String, dynamic>> items;

  UpdateWeightEvent(this.orderId, this.items);
}
class AcceptOrderEvent extends OrdersEvent {
  final int orderId;
  AcceptOrderEvent(this.orderId);
}
