import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

List<Product> mock = [
  Product(id: 0, imageUrl: 'imageUrl', price: 300, name: 'Airpods'),
  Product(id: 1, imageUrl: 'imageUrl', price: 700, name: 'Iphone XR'),
];

void main() {
  setupDependencyAssembler();

  var cartViewModel = dependencyAssembler<CartModel>();

  cartViewModel.addToCart(mock[0]);
  cartViewModel.addToCart(mock[1]);

  cartViewModel.getCartSummary();

  group('Checkout should work properly', () {
    test('Checkout should show the total cost of items in the cart', () async {
      expect(cartViewModel.cartSize, 2);
      expect(cartViewModel.totalCost, 1000);
    });

    test('Clear items in cart when done', () async {
      cartViewModel.clearCart();
      expect(cartViewModel.cartSize, 0);
    });
  });
}
