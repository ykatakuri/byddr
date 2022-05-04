class Product {
  int? id;
  int? userId;
  String? productName;
  String? productDescription;
  String? productFile;
  double? productPrice;

  Product({
    this.id,
    this.userId,
    this.productName,
    this.productDescription,
    this.productFile,
    this.productPrice,
  });

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        userId: json['id_user'],
        productName: json['name'],
        productDescription: json['description'],
        productFile: json['image'],
        productPrice: json['prix'].toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': userId,
      'name': productName,
      'description': productDescription,
      'image': productFile,
      'prix': productPrice,
    };
  }
}
