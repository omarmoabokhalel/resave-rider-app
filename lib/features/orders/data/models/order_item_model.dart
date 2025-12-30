class OrderItemModel {
  final int id;
  final String itemName;
  final double estimatedQuantity;
  final String image;

  OrderItemModel({
    required this.id,
    required this.itemName,
    required this.estimatedQuantity,
    required this.image
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      itemName: json['item']['name'],
      estimatedQuantity:
          double.parse(json['estimated_quantity'].toString()),
      image: json['image'] ?? '',
    );
  }
}
