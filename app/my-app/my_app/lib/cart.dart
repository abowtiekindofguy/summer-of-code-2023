import'product.dart';

class Cart {
  List<Product> products = [];

  void addToCart(Product product) {
    products.add(product);
  }
}
// class CartProvider {
//   static final Cart _cart = Cart();

//   factory CartProvider() {
//     return _cart;
//   }
// }