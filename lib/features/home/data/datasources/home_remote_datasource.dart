import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> getHomes();
  Future<HomeModel> getHomeById(String id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<HomeModel>> getHomes() async {
    throw UnimplementedError();
  }

  @override
  Future<HomeModel> getHomeById(String id) async {
    throw UnimplementedError();
  }
}
