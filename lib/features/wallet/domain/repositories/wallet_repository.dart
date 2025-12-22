import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/wallet_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, List<WalletEntity>>> getWallets();
  Future<Either<Failure, WalletEntity>> getWalletById(String id);
}
