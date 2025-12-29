import '../storage/token_storage.dart';

class AppStart {
  static Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getToken();
    return token != null;
  }
}
