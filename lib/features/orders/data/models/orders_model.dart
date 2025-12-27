import 'order_item_model.dart';

class OrderModel {
  final int id;
  final String status;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
