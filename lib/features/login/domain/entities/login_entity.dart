import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String id;
  final String name;

  const LoginEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
