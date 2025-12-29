class RiderModel {
  final int id;
  final String name;
  final String email;
  final String token;

  RiderModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['rider']['id'] as int,
      name: json['rider']['name'] as String,
      email: json['rider']['email'] as String,
      token: json['token'] as String,
    );
  }
}
