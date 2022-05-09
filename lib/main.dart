import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        title: 'BYDDR',
        home: OnBoardingScreen(),
        getPages: [
          GetPage(name: '/', page: () => const LoginScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(
              name: '/registration', page: () => const RegistrationScreen()),
          GetPage(name: "/login", page: () => const LoginScreen())
        ],
        routes: {
          '/login': (context) => const LoginScreen(),
          '/registration': (context) => const RegistrationScreen(),
          '/home': (context) => const HomeScreen()
        },
      );
    }));
  }
}
