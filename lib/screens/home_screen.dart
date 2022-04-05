import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/screens/add_product_screen.dart';
import 'package:project/screens/my_product_screen.dart';
import 'package:project/screens/product_list_screen.dart';
import 'package:project/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  //bool isActive = false;

  final Widget _productList = const ProductListScreen();
  final Widget _addProduct = const AddProductScreen();
  final Widget _myProduct = const MyProductScreen();
  final Widget _profile = const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        iconSize: 22.r,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          productList(),
          addProduct(),
          myProduct(),
          profile(),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  BottomNavigationBarItem profile() {
    return const BottomNavigationBarItem(
      icon: const BottomIcon(
        icon: Iconsax.profile_2user,
        isActive: false,
      ),
      label: 'Compte',
    );
  }

  BottomNavigationBarItem myProduct() {
    return const BottomNavigationBarItem(
      icon: BottomIcon(
        icon: Iconsax.wallet_3,
        isActive: false,
      ),
      label: 'Mes produits',
    );
  }

  BottomNavigationBarItem addProduct() {
    return const BottomNavigationBarItem(
      icon: BottomIcon(
        icon: Iconsax.add_square,
        isActive: false,
      ),
      label: 'Vendre',
    );
  }

  BottomNavigationBarItem productList() {
    return const BottomNavigationBarItem(
      icon: BottomIcon(
        icon: Iconsax.home,
        isActive: false,
      ),
      label: 'Accueil',
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _productList;
    } else if (selectedIndex == 1) {
      return _addProduct;
    } else if (selectedIndex == 2) {
      return _myProduct;
    } else {
      return _profile;
    }
  }

  onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
      //isActive = true;
    });
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon({Key? key, required this.icon, this.isActive = false})
      : super(key: key);
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Divider(
          thickness: 2,
          indent: 25.w,
          endIndent: 25.w,
          color: isActive ? Colors.black : Colors.transparent,
        )
      ],
    );
  }
}
