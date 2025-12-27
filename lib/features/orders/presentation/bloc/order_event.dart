abstract class OrdersEvent {}

class LoadOrders extends OrdersEvent {}

class SubmitWeight extends OrdersEvent {
  final int orderId;
  final List<Map<String, dynamic>> items;

  SubmitWeight(this.orderId, this.items);
}
