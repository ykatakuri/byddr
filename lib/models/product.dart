class Product {
  String? uid;
  String? userId;
  String? productName;
  String? productDescription;
  String? productFile;
  double? productPrice;
  double? bidWinnerPrice;

  Product(
      {this.uid,
      this.userId,
      this.productName,
      this.productDescription,
      this.productFile,
      this.productPrice,
      this.bidWinnerPrice});

  factory Product.fromJson(map) {
    return Product(
      uid: map['uid'],
      userId: map['userId'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      productFile: map['productFile'],
      productPrice: map['productPrice'],
      bidWinnerPrice: map['bidWinnerPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': userId,
      'productName': productName,
      'productDescription': productDescription,
      'productFile': productFile,
      'productPrice': productPrice,
      'bidWinnerPrice': bidWinnerPrice,
    };
  }
}
