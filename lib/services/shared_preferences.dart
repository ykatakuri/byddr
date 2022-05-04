import 'dart:ffi';

import 'package:project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(AppUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.id!);
    prefs.setString('firstname', user.firstname!);
    prefs.setString('lastname', user.lastname!);
    prefs.setString('username', user.username!);
    prefs.setString('email', user.email!);
    prefs.setString('token', user.token!);

    return prefs.commit();
  }

  Future<AppUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? username = prefs.getString("username");
    String? email = prefs.getString("email");
    String? token = prefs.getString("token");
    String? renewalToken = prefs.getString("renewalToken");

    return AppUser(
        id: userId,
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        token: token,
        renewalToken: renewalToken);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('type');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
