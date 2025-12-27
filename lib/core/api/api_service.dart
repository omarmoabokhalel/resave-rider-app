import 'package:dio/dio.dart';

class ApiService {
  late Dio dio;

  ApiService(String token) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
  }
}
