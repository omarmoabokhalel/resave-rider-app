import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/main_entity.dart';

abstract class MainRepository {
  Future<Either<Failure, List<MainEntity>>> getMains();
  Future<Either<Failure, MainEntity>> getMainById(String id);
}
