import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  const HomeModel({required super.id, required super.name});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
