import '../models/wallet_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<WalletModel>> getWallets();
  Future<WalletModel> getWalletById(String id);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  @override
  Future<List<WalletModel>> getWallets() async {
    throw UnimplementedError();
  }

  @override
  Future<WalletModel> getWalletById(String id) async {
    throw UnimplementedError();
  }
}
