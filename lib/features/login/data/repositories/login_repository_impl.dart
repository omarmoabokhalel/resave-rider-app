import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LoginEntity>>> getLogins() async {
    try {
      final result = await remoteDataSource.getLogins();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> getLoginById(String id) async {
    try {
      final result = await remoteDataSource.getLoginById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
