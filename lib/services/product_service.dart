// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

import 'package:project/models/product.dart';

import 'package:http/http.dart' as http;
import 'package:project/models/user.dart';
import 'package:project/services/network_handler.dart';
import 'package:project/utils/app_url.dart';

class ProductService {
  createProduct(String productName, String productDescription,
      String productFile, double productPrice) async {
    String? token = await NetworkHandler.getToken();

    final response = await http.post(
      Uri.parse('${AppURL.baseURL}api/produit'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'name': productName,
        'description': productDescription,
        'image': productFile,
        'prix': productPrice,
      }),
    );

    if (response.statusCode == 200) {
      return "Product created";
    } else {
      throw Exception('Failed to add the product.');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('${AppURL.baseURL}api/produit'),
    );

    if (response.statusCode == 200) {
      List responseJson = jsonDecode(response.body);
      return responseJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<AppUser> fetchProductOwner(int productId) async {
    final response = await http.get(
      Uri.parse('${AppURL.baseURL}api/produit/$productId/user'),
    );

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);

      return AppUser.fromJson(responseJson);
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Product>> fetchUserProducts() async {
    String? token = await NetworkHandler.getToken();

    final response = await http.get(
      Uri.parse('${AppURL.baseURL}api/user/produits'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List responseJson = jsonDecode(response.body);
      return responseJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
