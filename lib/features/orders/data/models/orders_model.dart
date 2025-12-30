import 'order_item_model.dart';
class OrderModel {
  final int id;
  final String status;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? riderId;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    this.address,
    this.latitude,
    this.longitude,
    this.riderId,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      address: json['address'],
      latitude: json['latitude'] == null
          ? null
          : double.parse(json['latitude'].toString()),
      longitude: json['longitude'] == null
          ? null
          : double.parse(json['longitude'].toString()),
      riderId: json['rider_id'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
