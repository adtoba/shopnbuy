import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

List<Product> mockProducts = [
  Product(id: 1, name: 'Airpods', imageUrl: 'imageUrl', price: 4000),
  Product(id: 2, name: 'Earphones', imageUrl: 'imageUrl', price: 4000),
  Product(id: 3, name: 'Iphone XR', imageUrl: 'imageUrl', price: 4000),
  Product(id: 4, name: 'Samsung', imageUrl: 'imageUrl', price: 4000),
];

void main() {
  setupDependencyAssembler();

  var cartViewModel = dependencyAssembler<CartModel>();

  cartViewModel.addToCart(mockProducts[0]);
  cartViewModel.addToCart(mockProducts[1]);
  cartViewModel.addToCart(mockProducts[2]);
  cartViewModel.addToCart(mockProducts[3]);
  cartViewModel.addToCart(mockProducts[2]);
  cartViewModel.addToCart(mockProducts[0]);

  group('Given cart page loads', () {
    test('Page should load list of products added to the cart', () async {
      expect(cartViewModel.cartSize, 6);
      expect(cartViewModel.getCartSummary().keys.length, 4);
    });

    test('Page should show accurate summary data', () async {
      cartViewModel.getCartSummary();
      expect(cartViewModel.getProduct(0).id, 1);
      expect(cartViewModel.getProduct(1).id, 2);
      expect(cartViewModel.getProduct(2).id, 3);
      expect(cartViewModel.getProduct(3).id, 4);

      expect(cartViewModel.getProductQuantity(0), 2);
      expect(cartViewModel.getProductQuantity(1), 1);
      expect(cartViewModel.getProductQuantity(2), 2);
      expect(cartViewModel.getProductQuantity(3), 1);
    });
  });
}
