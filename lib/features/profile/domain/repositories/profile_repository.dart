import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getProfiles();
  Future<Either<Failure, ProfileEntity>> getProfileById(String id);
}
