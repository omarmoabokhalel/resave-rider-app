import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getProfiles();
  Future<ProfileModel> getProfileById(String id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<List<ProfileModel>> getProfiles() async {
    throw UnimplementedError();
  }

  @override
  Future<ProfileModel> getProfileById(String id) async {
    throw UnimplementedError();
  }
}
