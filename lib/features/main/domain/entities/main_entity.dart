import 'package:equatable/equatable.dart';

class MainEntity extends Equatable {
  final String id;
  final String name;

  const MainEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
