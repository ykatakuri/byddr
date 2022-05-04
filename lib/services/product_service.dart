import 'dart:convert';
import 'dart:io';

import 'package:project/models/product.dart';

import 'package:http/http.dart' as http;
import 'package:project/utils/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Product> createProduct(String productName, String productDescription,
      String productFilePath, String productPrice) async {
    final token = await getToken();

    //final token =
    //    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9lbmNoZXJlcy15bm92Lmhlcm9rdWFwcC5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE2NTA5NjcxMzQsImV4cCI6MTY1MDk3MDczNCwibmJmIjoxNjUwOTY3MTM0LCJqdGkiOiJzOGhaZmQxWENsNDBnUmZQIiwic3ViIjoyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.fNz0b9R-yVG9QsdaqIjgvjen1-9Xbc9daddqvV-vqcA";

    final response = await http.post(
      Uri.parse('${AppURL.baseURL}api/produit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: '{Bearer $token}',
      },
      body: jsonEncode(<String, dynamic>{
        'name': productName,
        'description': productDescription,
        'image': productFilePath,
        'prix': productPrice,
      }),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add the product.');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final token = await getToken();

    print('AUTH USER TOKEN: $token');

    final response = await http.get(
      Uri.parse('${AppURL.baseURL}api/produit'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: '{Bearer $token}',
      },
    );

    if (response.statusCode == 200) {
      List responseJson = jsonDecode(response.body);
      return responseJson.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  List<Product> getProducts() {
    List<Product> products = [
      Product(
        id: 1,
        productName: 'Product 1',
        productDescription: 'Product 1 description',
        productFile: 'assets/images/image-0.jpg',
        productPrice: 100,
      ),
      Product(
        id: 2,
        productName: 'Product 2',
        productDescription: 'Product 2 description',
        productFile: 'assets/images/image-1.jpg',
        productPrice: 200,
      ),
      Product(
        id: 3,
        productName: 'Product 3',
        productDescription: 'Product 3 description',
        productFile: 'assets/images/image-0.jpg',
        productPrice: 300,
      ),
      Product(
        id: 4,
        productName: 'Product 4',
        productDescription: 'Product 4 description',
        productFile: 'assets/images/image-1.jpg',
        productPrice: 400,
      ),
      Product(
        id: 5,
        productName: 'Product 5',
        productDescription: 'Product 5 description',
        productFile: 'assets/images/image-0.jpg',
        productPrice: 500,
      ),
      Product(
        id: 6,
        productName: 'Product 6',
        productDescription: 'Product 6 description',
        productFile: 'assets/images/image-1.jpg',
        productPrice: 600,
      ),
    ];

    return products;
  }
}
