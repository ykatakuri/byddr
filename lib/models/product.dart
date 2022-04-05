class Product {
  String? uid;
  String? userId;
  String? userFirstName;
  String? userLastName;
  String? productName;
  String? productDescription;
  String? productFile;
  double? productPrice;
  double? bidWinnerPrice;

  Product(
      {this.uid,
      this.userId,
      this.userFirstName,
      this.userLastName,
      this.productName,
      this.productDescription,
      this.productFile,
      this.productPrice,
      this.bidWinnerPrice});

  static Product fromJson(Map<String, dynamic> json) => Product(
        uid: json['uid'],
        userId: json['userId'],
        userFirstName: json['userFirstName'],
        userLastName: json['userLastName'],
        productName: json['productName'],
        productDescription: json['productDescription'],
        productFile: json['productFile'],
        productPrice: json['productPrice'],
        bidWinnerPrice: json['bidWinnerPrice'],
      );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': userId,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'productName': productName,
      'productDescription': productDescription,
      'productFile': productFile,
      'productPrice': productPrice,
      'bidWinnerPrice': bidWinnerPrice,
    };
  }
}
