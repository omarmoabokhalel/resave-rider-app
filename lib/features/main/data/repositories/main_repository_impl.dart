import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/main_entity.dart';
import '../../domain/repositories/main_repository.dart';
import '../datasources/main_remote_datasource.dart';

class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource remoteDataSource;

  MainRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MainEntity>>> getMains() async {
    try {
      final result = await remoteDataSource.getMains();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MainEntity>> getMainById(String id) async {
    try {
      final result = await remoteDataSource.getMainById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
