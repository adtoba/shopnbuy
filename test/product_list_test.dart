// TODO 2: Create MockAPI Class
import 'package:flutter_test/flutter_test.dart';
import 'package:shopnbuy/core/models/product.dart';
import 'package:shopnbuy/core/services/api.dart';
import 'package:shopnbuy/core/viewmodels/cart_model.dart';
import 'package:shopnbuy/core/viewmodels/product_list_model.dart';
import 'package:shopnbuy/helpers/dependency_assembly.dart';

class MockAPI extends API {
  @override
  Future<List<Product>> getProducts() {
    return Future.value([
      Product(id: 1, name: 'MacBook pro 16', imageUrl: 'imageUrl', price: 2000),
      Product(id: 2, name: 'Problem', imageUrl: 'imageUrl', price: 5000)
    ]);
  }
}

// TODO 5: Declare a Mock Product

void main() {
  // TODO 3: Call Dependency Injector
  setupDependencyAssembler();

  // TODO 6: Inject Cart View Model
  var productListViewModel = dependencyAssembler<ProductListModel>();

  // TODO 4: Write Product List Page Test Cases
  productListViewModel.api = MockAPI();

  group('Given Product List Page Loads', () {
    test('Page should load a list of products from firebase', () async {
      await productListViewModel.getProducts();

      expect(productListViewModel.products.length, 2);

      expect(productListViewModel.products[0].name, 'MacBook pro 16');
      expect(productListViewModel.products[0].price, 2000);
      expect(productListViewModel.products[1].name, 'Problem');
    });
  });

  final Product product = Product(
      id: 0, name: 'Problem no dey finish', imageUrl: 'imageUrl', price: 4000);

  var cartViewModel = dependencyAssembler<CartModel>();

  test('Items in cart should increment by 1', () async {
    cartViewModel.addToCart(product);

    expect((cartViewModel.cartSize), 1);
  });

  // TODO 7: Write Add to Cart Logic Test Case
}
