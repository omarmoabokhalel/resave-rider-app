import 'package:resave_rider/core/api/api_service.dart';
import 'package:resave_rider/features/auth/data/models/rider_model.dart';

class AuthRemoteDataSource {
  final ApiService api;

  AuthRemoteDataSource(this.api);

  Future<RiderModel> login(String phone, String password) async {
    final response = await api.dio.post(
      "/rider/login",
      data: {
        "phone": phone,
        "password": password,
      },
    );
    return RiderModel.fromJson(response.data);
  }
}
