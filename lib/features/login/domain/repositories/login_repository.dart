import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, List<LoginEntity>>> getLogins();
  Future<Either<Failure, LoginEntity>> getLoginById(String id);
}
