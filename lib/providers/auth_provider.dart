// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project/models/user.dart';
import 'package:project/services/shared_preferences.dart';
import 'package:project/utils/app_url.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status loggedInStatus = Status.NotLoggedIn;
  Status registeredInStatus = Status.NotRegistered;

  Future<FutureOr> registration(
      String firstname,
      String lastname,
      String username,
      String email,
      String password,
      String passwordConfirmation,
      int idRole) async {
    final Map<String, dynamic> apiBodyData = {
      "firstname": firstname,
      "lastname": lastname,
      "username": username,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "id_role": idRole
    };

    return await post(Uri.parse(AppURL.registration),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static Future<FutureOr> onValue(Response response) async {
    Map<String, Object> result;

    final Map<String, dynamic> responseData = jsonDecode(response.body);

    print(responseData);

    if (response.statusCode == 200) {
      var userData = responseData;

      // now we will create a user model
      AppUser authUser = AppUser.fromJson(userData);

      // now we will create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppURL.login),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
        'X-ApiKey': 'ZGlzIzEyMw=='
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      print(responseData);

      var userData = responseData;

      AppUser authUser = AppUser.fromJson(userData);

      UserPreferences().saveUser(authUser);

      loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {'status': false, 'message': jsonDecode(response.body)['error']};
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
