import '../../domain/entities/main_entity.dart';

class MainModel extends MainEntity {
  const MainModel({required super.id, required super.name});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
