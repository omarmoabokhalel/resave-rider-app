import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getHomes();
  Future<Either<Failure, HomeEntity>> getHomeById(String id);
}
