import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/page_transition.dart';
import 'package:project/animations/slide_animation.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/screens/product_screen.dart';
import 'package:project/utils/constants.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final double _padding = 24;

  PageController _pageController = PageController(initialPage: 0);

  User? user = FirebaseAuth.instance.currentUser;
  AppUser loggedInUser = AppUser();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = AppUser.fromMap(value.data());
      setState(() {});
    });
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
              child: StreamBuilder<List<Product>>(
                  stream: readProducts(),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              child: const ProductScreen(),
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
                  const Spacer(),
                  Text(
                    '@${product.userFirstName} ${product.userLastName}',
                    style: TextStyle(
                      fontSize: 14.r,
                      color: Colors.black54,
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
                        image: NetworkImage("${product.productFile}"),
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
                  const EventStat(
                    title: '20h: 25m: 08s',
                    subtitle: 'Temps Restant',
                  ),
                  EventStat(
                    title: '${product.productPrice} BTC',
                    subtitle: 'Meilleure Offre',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Stream<List<Product>> readProducts() => FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
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
