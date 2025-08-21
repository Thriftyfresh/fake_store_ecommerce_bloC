import 'package:fake_store/data/datasources/api_service.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/core/constants/api_endpoints.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiService.get(ApiEndpoints.products);
    return (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await _apiService.get(ApiEndpoints.productById(id));
    return ProductModel.fromJson(response.data);
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.productsByCategory(category),
      );

      // Convert the response data to List<ProductModel>
      return (response.data as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
    } catch (e) {
      // Handle any errors that might occur
      throw Exception('Failed to load products by category: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final allProducts = await getProducts();
    print('Search query: $query');
    print('Total products: ${allProducts.length}');

    // Simple case-insensitive search
    final results = allProducts
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    
    print('Search results: ${results.length}');
    return results;
  }
}
