import '../models/main_model.dart';

abstract class MainRemoteDataSource {
  Future<List<MainModel>> getMains();
  Future<MainModel> getMainById(String id);
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  @override
  Future<List<MainModel>> getMains() async {
    throw UnimplementedError();
  }

  @override
  Future<MainModel> getMainById(String id) async {
    throw UnimplementedError();
  }
}
