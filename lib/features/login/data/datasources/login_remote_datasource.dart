import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<List<LoginModel>> getLogins();
  Future<LoginModel> getLoginById(String id);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<List<LoginModel>> getLogins() async {
    throw UnimplementedError();
  }

  @override
  Future<LoginModel> getLoginById(String id) async {
    throw UnimplementedError();
  }
}
