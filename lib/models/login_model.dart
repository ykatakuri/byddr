import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => jsonEncode(data.toJson());

class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
