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
      id: json['rider']['id'],
      name: json['rider']['name'],
      email: json['rider']['email'],
      token: json['token'],
    );
  }
}
