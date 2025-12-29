import 'package:dio/dio.dart';
import 'package:resave_rider/core/api/api_service.dart';
import '../models/rider_model.dart';

class AuthRemoteDataSource {
  final ApiService api;

  AuthRemoteDataSource(this.api);

  Future<RiderModel> loginRider(String email, String password) async {
    try {
      final response = await api.dio.post(
        '/login/rider',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return RiderModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
