// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/fade_animation.dart';
import 'package:project/animations/page_transition.dart';
import 'package:project/animations/slide_animation.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/screens/login_screen.dart';
import 'package:project/utils/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  static const primaryColor = Color(0xff320C7E);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final double _padding = 40;

  final _headingStyle = const TextStyle(
    fontWeight: FontWeight.w200,
    fontFamily: 'Dsignes',
    color: Colors.black,
  );

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: const _AppBar(),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: FadeAnimation(
                intervalEnd: 0.4,
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/flash.svg',
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Bienvenue sur BYDDR',
                      style: TextStyle(
                        fontSize: 12.r,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: SlideAnimation(
                intervalEnd: 0.6,
                child: FadeAnimation(
                  intervalEnd: 0.6,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 40.r,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dsignes',
                        color: Colors.black,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: 'Découvrez ',
                          style: _headingStyle,
                        ),
                        TextSpan(
                          text: "Des ",
                          style: _headingStyle,
                        ),
                        const TextSpan(
                          text: 'Collections ',
                          style:
                              TextStyle(color: OnBoardingScreen.primaryColor),
                        ),
                        const TextSpan(
                          text: 'Digitales',
                          style:
                              TextStyle(color: OnBoardingScreen.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: FadeAnimation(
                child: Text(
                  'Marketplace digitale pour tous vos produits numériques',
                  style: bodyTextStyle,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              height: 200.h,
              padding: EdgeInsets.only(left: _padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SlideAnimation(
                    intervalStart: 0.4,
                    begin: const Offset(0, 20),
                    child: FadeAnimation(
                      intervalStart: 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const <Widget>[
                          EventStat(
                            title: '12.1K+',
                            subtitle: "Oeuvre",
                          ),
                          EventStat(
                            title: '1.7M+',
                            subtitle: 'Artiste',
                          ),
                          EventStat(
                            title: '45K+',
                            subtitle: 'Enchère',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 60.w),
                  Expanded(
                    child: SlideAnimation(
                      intervalStart: 0.2,
                      child: FadeAnimation(
                        intervalEnd: 0.2,
                        child: Container(
                          padding: EdgeInsets.all(24.r),
                          decoration: const BoxDecoration(
                            color: OnBoardingScreen.primaryColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (homeController.loggedIn == true) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const LoginScreen(),
                                        type: PageTransitionType.fadeIn,
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const LoginScreen(),
                                        type: PageTransitionType.fadeIn,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 40.r,
                                  height: 40.r,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Iconsax.arrow_right_1),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                'Explorer',
                                style: TextStyle(
                                  fontSize: 24.r,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 9,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Divider(
                                thickness: 2,
                                endIndent: 120.w,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _padding),
              child: SlideAnimation(
                begin: const Offset(0, 20),
                intervalStart: 0.6,
                child: FadeAnimation(
                  intervalStart: 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Supporté Par',
                        style: bodyTextStyle,
                      ),
                      SvgPicture.asset(
                        'assets/images/binance.svg',
                        width: 24.r,
                      ),
                      SvgPicture.asset(
                        'assets/images/huobi.svg',
                        width: 22.r,
                      ),
                      SvgPicture.asset(
                        'assets/images/xrp.svg',
                        width: 22.r,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const AppLogo(),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
          child: const Center(
            child: Icon(
              Iconsax.wallet_1,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'BYDDR',
      style: TextStyle(
        fontSize: 26.r,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ColoredText extends StatelessWidget {
  const ColoredText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 0,
            left: 10.w,
            child: Container(
              width: 85.w,
              height: 30.r,
              color: const Color(0xffaafaff),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 40.r,
              fontWeight: FontWeight.bold,
              fontFamily: 'Dsignes',
              color: Colors.black,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class EventStat extends StatelessWidget {
  const EventStat({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.r,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class Countdown extends StatelessWidget {
  const Countdown({Key? key, required this.time, required this.subtitle})
      : super(key: key);

  final Widget time;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        time,
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.r,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
