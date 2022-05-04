import 'package:flutter/cupertino.dart';
import 'package:project/models/user.dart';

class UserProvider extends ChangeNotifier {
  AppUser _user = AppUser();

  AppUser get user => _user;

  void setUser(AppUser user) {
    _user = user;
    notifyListeners();
  }
}
