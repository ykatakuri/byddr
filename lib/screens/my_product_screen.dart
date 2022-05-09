import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/page_transition.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/screens/product_screen.dart';
import 'package:project/services/product_service.dart';
import 'package:project/utils/app_url.dart';
import 'package:project/utils/constants.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  final double _padding = 24;
  late Future<List<Product>> futureProduct;

  @override
  void initState() {
    super.initState();

    futureProduct = ProductService().fetchUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
          Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Product>>(
              future: futureProduct,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Erreur ! ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;

                  return ListView(
                    physics: const ScrollPhysics(),
                    children: products.map(buildProduct).toList(),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: customPrimaryColor,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: ListTile(
          leading: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: NetworkImage(
                      "${AppURL.baseURL}img/${product.productFile}"),
                  fit: BoxFit.cover),
            ),
          ),
          title: Text("${product.productName}"),
          subtitle: Text(
            "${product.productDescription}",
          ),
          minVerticalPadding: 20,
          contentPadding: const EdgeInsets.all(10),
        ),
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
              'Hello',
              style: bodyTextStyle,
            ),
            SizedBox(height: 8.h),
            Text(
              'Mes Produits',
              style: TextStyle(
                fontSize: 26.r,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'La liste de vos produits !',
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
