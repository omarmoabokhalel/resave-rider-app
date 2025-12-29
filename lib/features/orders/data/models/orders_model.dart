import 'package:resave_rider/features/orders/data/models/order_item_model.dart';

class OrderModel {
  final int id;
  final String status;
  final String address;
  final double lat;
  final double lng;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.address,
    required this.lat,
    required this.lng,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      address: json['address'],
      lat: double.parse(json['lat'].toString()),
      lng: double.parse(json['lng'].toString()),
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
