import 'package:resave_rider/features/auth/domain/entities/rider.dart';

class RiderModel extends Rider {
  RiderModel({
    required super.id,
    required super.name,
    required super.token,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['rider']['id'],
      name: json['rider']['name'],
      token: json['token'],
    );
  }
}
