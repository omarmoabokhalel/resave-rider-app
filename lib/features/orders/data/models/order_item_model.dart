class OrderItemModel {
  final int id;
  final String itemName;
  final double estimatedQuantity;

  OrderItemModel({
    required this.id,
    required this.itemName,
    required this.estimatedQuantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      itemName: json['item']['name'],
      estimatedQuantity:
          double.parse(json['estimated_quantity'].toString()),
    );
  }
}
