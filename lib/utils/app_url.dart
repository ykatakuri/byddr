class AppURL {
  static const String baseURL = 'https://encheres-ynov.herokuapp.com/';

  static const String login = baseURL + 'api/auth/login';
  static const String registration = baseURL + 'api/auth/register';
  static const String userProducts = baseURL + 'api/user/produits';
  static const String products = baseURL + 'api/produit';
  static var productID;
  String productOwner = baseURL + 'api/produit/$productID/user';
}
