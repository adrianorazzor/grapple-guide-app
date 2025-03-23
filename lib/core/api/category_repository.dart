import '../models/category.dart';
import 'api_client.dart';

class CategoryRepository {
  final ApiClient _apiClient;
  
  CategoryRepository(this._apiClient);
  
  // Get all categories
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get('/categories');
      
      if (response is List) {
        return response
            .map((json) => Category.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      return [];
    } catch (e) {
      // Rethrow with more context
      throw 'Failed to fetch categories: $e';
    }
  }
  
  // Get a single category by ID
  Future<Category> getCategory(String id) async {
    try {
      final response = await _apiClient.get('/categories/$id');
      return Category.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to fetch category: $e';
    }
  }
  
  // Create a new category
  Future<Category> createCategory(Category category) async {
    try {
      final response = await _apiClient.post(
        '/categories',
        data: category.toJson(),
      );
      return Category.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to create category: $e';
    }
  }
  
  // Update an existing category
  Future<Category> updateCategory(Category category) async {
    try {
      final response = await _apiClient.put(
        '/categories/${category.id}',
        data: category.toJson(),
      );
      return Category.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to update category: $e';
    }
  }
  
  // Delete a category
  Future<void> deleteCategory(String id) async {
    try {
      await _apiClient.delete('/categories/$id');
    } catch (e) {
      throw 'Failed to delete category: $e';
    }
  }
} 