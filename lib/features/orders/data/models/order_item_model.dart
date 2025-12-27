class OrderItemModel {
  final int id;
  final String name;
  final double estimatedQuantity;
  final double price;

  OrderItemModel({
    required this.id,
    required this.name,
    required this.estimatedQuantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      name: json['item']['name'],
      estimatedQuantity:
          double.parse(json['estimated_quantity'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }
}
