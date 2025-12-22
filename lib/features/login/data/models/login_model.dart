import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.id, required super.name});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
