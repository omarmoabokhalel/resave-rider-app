import 'order_item_model.dart';
class OrderModel {
  final int id;
  final String status;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    this.address,
    this.latitude,
    this.longitude,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      address: json['address'],
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : null,
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
