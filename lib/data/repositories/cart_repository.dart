import 'package:fake_store/core/constants/api_endpoints.dart';
import 'package:fake_store/data/datasources/api_service.dart';
import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/data/repositories/product_repository_impl.dart';

class CartRepository {
  final ApiService _apiService;
  final ProductRepository _productRepository;

  CartRepository(this._apiService, this._productRepository);

  Future<CartModel> getUserCart(int userId) async {
    try {
      final response = await _apiService.get(ApiEndpoints.userCart(userId));

      if (response.data is List && response.data.isNotEmpty) {
        final cart = CartModel.fromJson(response.data[0]);

        // Enhance cart items with product details
        await _enrichCartItems(cart);
        return cart;
      }
      throw Exception('No cart found for user $userId');
    } catch (e) {
      throw Exception('Failed to load cart: ${e.toString()}');
    }
  }

  Future<void> _enrichCartItems(CartModel cart) async {
    for (final item in cart.products) {
      try {
        final product = await _productRepository.getProductById(item.productId);
        item.title = product.title;
        item.price = product.price;
        item.image = product.image;
      } catch (e) {
        // Fallback values if product fetch fails
        item.title = 'Product ${item.productId}';
        item.price = 0.0;
        item.image = '';
      }
    }
  }

  Future<CartModel> addToCart({
    required int userId,
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.carts,
        data: {
          'userId': userId,
          'date': DateTime.now().toIso8601String(),
          'products': [
            {'productId': productId, 'quantity': quantity},
          ],
        },
      );
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add to cart: ${e.toString()}');
    }
  }

  Future<CartModel> updateCartItem({
    required int cartId,
    required int productId,
    required int newQuantity,
  }) async {
    try {
      final response = await _apiService.put(
        '${ApiEndpoints.carts}/$cartId',
        data: {
          'products': [
            {'productId': productId, 'quantity': newQuantity},
          ],
        },
      );
      return CartModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update cart: ${e.toString()}');
    }
  }

  Future<void> addProductToExistingCart(
    CartModel cart,
    int productId,
    int quantity,
  ) async {
    // Check if product already exists
    final existingItemIndex = cart.products.indexWhere(
      (item) => item.productId == productId,
    );

    if (existingItemIndex != -1) {
      // Product exists, increment quantity
      cart.products[existingItemIndex].quantity += quantity;
    } else {
      // Product doesn't exist, add new item
      final newItem = CartItem(productId: productId, quantity: quantity);

      // Enrich the new item with product details
      try {
        final product = await _productRepository.getProductById(productId);
        newItem.title = product.title;
        newItem.price = product.price;
        newItem.image = product.image;
      } catch (e) {
        // Fallback values if product fetch fails
        newItem.title = 'Product $productId';
        newItem.price = 0.0;
        newItem.image = '';
      }

      cart.products.add(newItem);
    }
  }
}
