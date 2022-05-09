import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:project/models/login_model.dart';
import 'package:project/models/registration_model.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/screens/registration_screen.dart';
import 'package:project/services/network_handler.dart';

class RegistrationController extends GetxController {
  TextEditingController firstnameEditingController = TextEditingController();
  TextEditingController lastnameEditingController = TextEditingController();
  TextEditingController usernameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();

  void registrer() async {
    RegistrationModel registrationModel = RegistrationModel(
      firstname: firstnameEditingController.text,
      lastname: lastnameEditingController.text,
      username: usernameEditingController.text,
      email: emailEditingController.text,
      password: passwordEditingController.text,
      passwordConfirmation: confirmPasswordEditingController.text,
      roleId: 3,
    );

    dynamic response = await NetworkHandler.post(
        registrationModelToJson(registrationModel), "auth/register");

    dynamic data = json.decode(response);

    print(data);

    await NetworkHandler.storeToken(data["access_token"]);

    if (data["error"] != null) {
      Fluttertoast.showToast(msg: "Compte non créé");
    } else {
      Fluttertoast.showToast(msg: "Bienvenue :) !!!");
      await NetworkHandler.storeToken(data["access_token"].toString());
      Get.offAllNamed("/home");
    }
  }
}
