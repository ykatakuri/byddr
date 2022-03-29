class AppUser {
  String? uid;
  String? email;
  String? lastName;
  String? firstName;

  AppUser({this.uid, this.email, this.lastName, this.firstName});

  factory AppUser.fromMap(map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      lastName: map['lastName'],
      firstName: map['firstName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'lastName': lastName,
      'firstName': firstName,
    };
  }
}
