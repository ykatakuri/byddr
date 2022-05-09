import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:project/models/login_model.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/registration_screen.dart';
import 'package:project/services/network_handler.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    LoginModel loginModel = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );

    dynamic response =
        await NetworkHandler.post(loginModelToJson(loginModel), "auth/login");

    dynamic data = json.decode(response);
    //print(data);

    if (data["error"] != null) {
      Fluttertoast.showToast(msg: "Utilisateur inconnu");
      Get.toNamed("/registration");
    } else {
      Fluttertoast.showToast(msg: "Content de vous revoir :) !!!");
      await NetworkHandler.storeToken(data["access_token"].toString());
      Get.offAllNamed("/home");
    }
  }
}
