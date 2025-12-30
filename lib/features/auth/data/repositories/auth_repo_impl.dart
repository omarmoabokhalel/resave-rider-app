
import 'package:resave_rider/features/auth/data/datasources/auth_remote_ds.dart';
import 'package:resave_rider/features/auth/domain/repositories/auth_repo.dart';

import '../models/rider_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<RiderModel> loginRider(String email, String password) {
    return remote.loginRider(email, password);
  }
}
