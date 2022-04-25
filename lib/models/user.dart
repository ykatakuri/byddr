class AppUser {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final int? idRole;
  final String? accessToken;

  AppUser({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.idRole,
    required this.accessToken,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      idRole: json['id_role'],
      accessToken: json['access_token'],
    );
  }
}
