import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  const WalletModel({required super.id, required super.name});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
