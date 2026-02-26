import '../../../core/network/api_client.dart';
import '../domain/models/product.dart';

class ProductRepository {
  final ApiClient apiClient;

  ProductRepository({required this.apiClient});

  Future<List<Product>> getProducts() async {
    try {
      final response = await apiClient.dio.get('/products');
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await apiClient.dio.get('/products/categories');
      final List<dynamic> data = response.data;
      return ['All Products', ...data.map((e) => e.toString())];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    if (category == 'All Products') {
      return getProducts();
    }

    try {
      final response = await apiClient.dio.get('/products/category/$category');
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products for category $category: $e');
    }
  }
}
