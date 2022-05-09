class AppUser {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? password;
  String? passwordConfirmation;
  int? idRole;
  String? token;

  AppUser({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.idRole,
    this.token,
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
      token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'email': email,
      };
}
