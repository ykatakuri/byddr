import 'dart:async';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/animations/fade_animation.dart';
import 'package:project/animations/slide_animation.dart';
import 'package:project/models/product.dart';
import 'package:project/utils/app_url.dart';

import '../utils/constants.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              const _AppBar(),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black26),
                ),
                child: Hero(
                  tag: '${widget.product.productName}',
                  child: Container(
                    height: 260.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: DecorationImage(
                          image: NetworkImage(
                              "${AppURL.baseURL}img/${widget.product.productFile}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SlideAnimation(
                intervalStart: 0.4,
                begin: const Offset(0, 30),
                child: FadeAnimation(
                  intervalStart: 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.product.productName}",
                        style: TextStyle(
                          fontSize: 24.r,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/profile.jpg',
                              width: 20.r,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Text(
                            '@${widget.product.userId}',
                            style: const TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "${widget.product.productDescription}",
                        style: bodyTextStyle,
                      ),
                      SizedBox(height: 8.h),
                      const Divider(),
                      SizedBox(height: 8.h),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/user.jpeg',
                            width: 40.r,
                            height: 40.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: const Text('Meilleure Offre Par'),
                        subtitle: Text(
                          'Merry Rose',
                          style: TextStyle(
                            fontSize: 16.r,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          "30 BTC",
                          style: TextStyle(
                            fontSize: 16.r,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: customPrimaryColor,
                        child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(60),
                                  ),
                                ),
                                builder: (context) => const Center(
                                  child: BottomSheetForm(),
                                ),
                              );
                            },
                            child: const Text(
                              "Enchérir",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        SizedBox(width: 16.h),
        Text(
          'Enchères',
          style: TextStyle(
            fontSize: 16.r,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        FavoriteButton(
          isFavorite: false,
          valueChanged: (_isFavorite) {
            print('Is Favorite : $_isFavorite');
          },
        ),
      ],
    );
  }
}

class BottomSheetForm extends StatefulWidget {
  const BottomSheetForm({Key? key}) : super(key: key);

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  final _formKey = GlobalKey<FormState>();

  final offerEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final priceField = TextFormField(
      autofocus: false,
      controller: offerEditingController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un prix");
        }
        return null;
      },
      onSaved: (value) {
        offerEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Montant de l'offre",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Montant de l'offre",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final cancelButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 100,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Annuler",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: customPrimaryColor,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 100,
          onPressed: () {
            Fluttertoast.showToast(msg: "Offre enregistrée.. ");
          },
          child: const Text(
            "Enchérir",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              priceField,
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cancelButton,
                  const SizedBox(width: 15),
                  submitButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
