import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/page_transition.dart';
import 'package:project/animations/slide_animation.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/screens/product_screen.dart';
import 'package:project/services/network_handler.dart';
import 'package:project/services/product_service.dart';
import 'package:project/utils/app_url.dart';
import 'package:project/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProduct;
  late Future<AppUser> futureProductUser;
  late int productId;

  final double _padding = 24;

  PageController _pageController = PageController(initialPage: 0);

  static const countdownDuration = Duration(minutes: 1);
  Duration duration = const Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();

    futureProduct = ProductService().fetchProducts();

    productId = 1;

    futureProductUser = ProductService().fetchProductOwner(productId);

    startTimer();
    //reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: const _AppBar(),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: const _Header(),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: const SlideAnimation(child: _CategoryList()),
          ),
          SizedBox(height: 24.h),
          SlideAnimation(
            begin: Offset(400.w, 0),
            child: SizedBox(
              height: 500,
              child: FutureBuilder<List<Product>>(
                  future: futureProduct,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Erreur ! ${snapshot.error}"));
                    } else if (snapshot.hasData) {
                      final products = snapshot.data!;

                      return PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: products.map(buildProduct).toList());
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: customPrimaryColor,
                      ));
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct(Product product) {
    productId = product.id!;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              child: ProductScreen(product: product),
              type: PageTransitionType.fadeIn,
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.w),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${product.productName}',
                    style: TextStyle(
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Hero(
                tag: '${product.productName}',
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                        image: NetworkImage(
                            "${AppURL.baseURL}img/${product.productFile}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Countdown(
                    time: buildTime(),
                    subtitle: 'Temps Restant',
                  ),
                  EventStat(
                    title: '${product.productPrice} BTC',
                    subtitle: 'Mise à prix',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$hours:$minutes:$seconds",
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.r,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    } else {
                      startTimer(resets: false);
                    }
                  },
                  child: Text(isRunning ? "STOP" : "RESUME")),
              const SizedBox(
                width: 12,
              ),
              TextButton(onPressed: () {}, child: const Text("CANCEL")),
            ],
          )
        : TextButton(onPressed: () {}, child: const Text("START TIMER"));
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);

  final List<String> _options = const [
    'Tendance',
    'Arts Digital',
    'Vidéos 3D',
    'Jeux',
    'PDF',
    'Collections',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _options.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index == 0 ? Colors.black : null,
            ),
            padding: EdgeInsets.only(
              left: 22.w,
              right: index == 0 ? 22.w : 0,
            ),
            child: Center(
              child: Text(
                _options[index],
                style: TextStyle(
                  fontSize: 14.r,
                  color: index == 0 ? Colors.white : Colors.black54,
                  fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Live',
              style: bodyTextStyle,
            ),
            SizedBox(height: 8.h),
            Text(
              'Enchères',
              style: TextStyle(
                fontSize: 26.r,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Profitez! Les dernières enchères à la Une',
              style: bodyTextStyle,
            ),
          ],
        ),
        const Icon(Iconsax.setting_4),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppLogo(),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/profile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
