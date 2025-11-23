import '../../domain/entities/user_entity.dart';

class LoginModel {
  final String token;
  final String name;
  final String email;

  LoginModel({required this.token, required this.name, required this.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      name: json['name'],
      email: json['email'],
    );
  }

  UserEntity toEntity() {
    return UserEntity(name: name, email: email, token: token);
  }
}
