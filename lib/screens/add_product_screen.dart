// ignore_for_file: unused_import, invalid_use_of_visible_for_testing_member, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/models/product.dart';
import 'package:project/screens/onboarding_screen.dart';
import 'package:project/services/product_service.dart';
import 'package:project/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final double _padding = 24;

  final _formKey = GlobalKey<FormState>();

  final productNameEditingController = TextEditingController();
  final productDescriptionEditingController = TextEditingController();
  final productPriceEditingController = TextEditingController();
  final productImageEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  File? file;

  Future selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result == null) return;

      final path = result.files.single.path;

      setState(() => file = File(path!));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future selectImage() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);

      if (result == null) return;

      final path = result.files.single.path;

      setState(() => file = File(path!));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeAPhoto() async {
    try {
      final result =
          await ImagePicker.platform.pickImage(source: ImageSource.camera);

      if (result == null) return;

      final path = result.path;

      //final path = result.files.single.path;

      setState(() => file = File(path));
    } on PlatformException catch (e) {
      print('Failed to snap photo: $e');
    }
  }

  _asyncFileUpload(File file) async {
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://encheres-ynov.herokuapp.com/api/produit"));
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("image", file.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Aucun fichier selectionné';

    final productNameField = TextFormField(
      autofocus: false,
      controller: productNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Donnez un nom à votre produit");
        }
        return null;
      },
      onSaved: (value) {
        productNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Nom du produit",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Nom du produit",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final productDescriptionField = TextFormField(
      autofocus: false,
      controller: productDescriptionEditingController,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Décrivez votre produit");
        }
        return null;
      },
      onSaved: (value) {
        productDescriptionEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Description du produit",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Description du produit",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final productPriceField = TextFormField(
      autofocus: false,
      controller: productPriceEditingController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Donnez un prix initial à votre produit");
        }
        return null;
      },
      onSaved: (value) {
        productPriceEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Mise à prix",
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Mise à prix du produit",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final selectFileActionSheet = CupertinoActionSheet(
      title: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.attach_file_outlined,
          color: customPrimaryColor,
          size: 30,
        ),
      ),
      message: const Text("Ajouter un fichier"),
      actions: [
        CupertinoActionSheetAction(
            onPressed: selectFile,
            child: const Text("Sélectionner un fichier")),
        CupertinoActionSheetAction(
            onPressed: selectImage,
            child: const Text("Sélectionner une image")),
        CupertinoActionSheetAction(
            onPressed: takeAPhoto, child: const Text("Prendre une photo")),
      ],
    );

    Future addProduct(String productName, String productDescription,
        String productFile, double productPrice) async {
      ProductService().createProduct(
          productName, productDescription, productFile, productPrice);
    }

    final addButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: customPrimaryColor,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            final String productName, productDescription;
            String? productFile;
            final double productPrice;

            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              productName = productNameEditingController.text;
              productDescription = productDescriptionEditingController.text;
              productFile = fileName;
              productPrice = double.parse(productPriceEditingController.text);

              _asyncFileUpload(file!);

              addProduct(
                  productName, productDescription, productFile, productPrice);

              Fluttertoast.showToast(msg: "Produit mis aux enchères.. ");

              productNameEditingController.text = "";
              productDescriptionEditingController.text = "";
              productPriceEditingController.text = "";
            } else {
              Fluttertoast.showToast(msg: "Une Erreur Est Survenue");
            }
          },
          child: const Text(
            "Publier",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

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
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    productNameField,
                    const SizedBox(height: 20),
                    productDescriptionField,
                    const SizedBox(height: 20),
                    productPriceField,
                    selectFileActionSheet,
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      fileName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    addButton,
                  ],
                ),
              ),
            ),
          ),
        ],
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
              'Vendre',
              style: TextStyle(
                fontSize: 26.r,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Ajoutez les détails du produit que vous voulez vendre !',
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
