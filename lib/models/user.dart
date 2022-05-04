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
  String? renewalToken;

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
    this.renewalToken,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      firstname: json['user']['firstname'],
      lastname: json['user']['lastname'],
      username: json['user']['username'],
      email: json['user']['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      idRole: json['id_role'],
      token: json['access_token'],
      renewalToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'email': email,
      };
}
