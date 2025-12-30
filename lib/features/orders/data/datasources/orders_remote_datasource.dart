import 'package:resave_rider/core/api/api_service.dart';
import 'package:resave_rider/features/orders/data/models/orders_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> acceptOrder(int orderId);
  Future<void> updateWeight(
    int orderId,
    List<Map<String, dynamic>> items,
  );
  Future<void> completeOrder(int orderId);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiService api;

  OrdersRemoteDataSourceImpl(this.api);

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await api.dio.get('/rider/orders');
    return (response.data as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> acceptOrder(int orderId) async {
    await api.dio.post('/rider/order/$orderId/accept');
  }

  @override
Future<void> updateWeight(
  int orderId,
  List<Map<String, dynamic>> items,
) async {
  final formData = FormData();

  for (int i = 0; i < items.length; i++) {
    formData.fields.addAll([
      MapEntry(
        'items[$i][order_item_id]',
        items[i]['order_item_id'].toString(),
      ),
      MapEntry(
        'items[$i][actual_quantity]',
        items[i]['actual_quantity'].toString(),
      ),
    ]);

    if (items[i]['confirm_image'] != null) {
      final XFile image = items[i]['confirm_image'];

      formData.files.add(
        MapEntry(
          'items[$i][confirm_image]',
          await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          ),
        ),
      );
    }
  }

  await api.dio.post(
    '/rider/order/$orderId/update-weight',
    data: formData,
  );
}

  @override
  Future<void> completeOrder(int orderId) async {
  await api.dio.post('/rider/order/$orderId/complete');
}

}


