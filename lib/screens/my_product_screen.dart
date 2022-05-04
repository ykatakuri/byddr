import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/page_transition.dart';
import 'package:project/models/product.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/screens/product_screen.dart';
import 'package:project/utils/constants.dart';

class MyProductScreen extends StatefulWidget {
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  final double _padding = 24;

  // User? user = FirebaseAuth.instance.currentUser;
  // AppUser loggedInUser = AppUser();

  @override
  void initState() {
    super.initState();
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
            color: customPrimaryColor,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<List<Product>>(
              stream: readProducts(),
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
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                image: NetworkImage("${product.productFile}"),
                fit: BoxFit.cover),
          ),
        ),
        title: Text("${product.productName}"),
        subtitle: Text(
          "${product.productDescription}",
        ),
      ),
    );
  }

  readProducts() {}

  /*
  Future<List<Iterable<Product>>> getUserProducts() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return  FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("products")
        .where("userId", isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromJson(doc.data())))
        .toList();
        
  }*/
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
