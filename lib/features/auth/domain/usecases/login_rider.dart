import 'package:resave_rider/features/auth/domain/repositories/auth_repo.dart';

import '../../data/models/rider_model.dart';

class LoginRider {
  final AuthRepository repository;

  LoginRider(this.repository);

  Future<RiderModel> call(String email, String password) {
    return repository.loginRider(email, password);
  }
}
