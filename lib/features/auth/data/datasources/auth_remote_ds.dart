import 'package:resave_rider/core/api/api_service.dart';
import '../models/rider_model.dart';

class AuthRemoteDataSource {
  final ApiService api;

  AuthRemoteDataSource(this.api);

  Future<RiderModel> loginRider(String email, String password) async {
    try {
      final response = await api.dio.post(
        '/login/rider',
        data: {'email': email, 'password': password},
      );

      print('LOGIN RESPONSE => ${response.data}');

      return RiderModel.fromJson(response.data);
    } catch (e) {
      print('LOGIN ERROR => $e');
      rethrow;
    }
  }
}
