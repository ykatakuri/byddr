import 'dart:convert';

import 'package:get/get.dart';
import 'package:project/models/user.dart';
import 'package:project/services/network_handler.dart';

class HomeController extends GetxController {
  RxString? token;
  RxBool loggedIn = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    checkLogin();
  }

  Future<String?> checkLogin() async {
    var scopedToken = await NetworkHandler.getToken();
    //AppUser? user;
    String? username;

    if (scopedToken != null) {
      token?.value = scopedToken;
      loggedIn.value = true;

      var response = await NetworkHandler.get("auth/user-profile", scopedToken);
      var data = json.decode(response);

      username = data["username"];

      print(username);

      //user = AppUser.fromJson(jsonDecode(response));

      //print("User from Home Controller: " + use);
    }

    return username;
  }

  void logout() async {
    await NetworkHandler.logout();
    loggedIn.value = false;
    token?.value = null?.obs;
    Get.offAllNamed("/login");
  }
}
