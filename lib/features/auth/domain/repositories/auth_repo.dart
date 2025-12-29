import '../../data/models/rider_model.dart';

abstract class AuthRepository {
  Future<RiderModel> loginRider(String email, String password);
}
