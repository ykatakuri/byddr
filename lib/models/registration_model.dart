import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    jsonEncode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.roleId,
  });

  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? password;
  String? passwordConfirmation;
  int? roleId;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        roleId: json["id_role"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "id_role": roleId,
      };
}
