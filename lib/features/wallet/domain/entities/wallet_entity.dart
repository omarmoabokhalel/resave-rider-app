import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String id;
  final String name;

  const WalletEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
