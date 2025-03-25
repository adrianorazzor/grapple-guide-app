import '../dtos/category_dto.dart';
import 'api_client.dart';
import '../logger/app_logger.dart';
import 'i_category_repository.dart';

class RemoteCategoryRepository implements ICategoryRepository {
  final ApiClient _apiClient;
  final AppLogger _logger = AppLogger();
  
  RemoteCategoryRepository(this._apiClient);
  
  @override
  Future<List<CategoryDTO>> getCategories() async {
    try {
      final response = await _apiClient.get('/categories');
      
      if (response is List) {
        return response
            .map((json) => CategoryDTO.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      return [];
    } catch (e) {
      _logger.e('Failed to fetch categories from remote source: $e');
      return [];
    }
  }
  
  @override
  Future<CategoryDTO?> getCategory(int id) async {
    try {
      final response = await _apiClient.get('/categories/$id');
      return CategoryDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to fetch category from remote source: $e');
      return null;
    }
  }
  
  @override
  Future<CategoryDTO?> createCategory(CategoryDTO category) async {
    try {
      final response = await _apiClient.post(
        '/categories',
        data: category.toJson(),
      );
      return CategoryDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to create category on remote source: $e');
      return null;
    }
  }
  
  @override
  Future<CategoryDTO?> updateCategory(CategoryDTO category) async {
    try {
      final response = await _apiClient.put(
        '/categories/${category.id}',
        data: category.toJson(),
      );
      return CategoryDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to update category on remote source: $e');
      return null;
    }
  }
  
  @override
  Future<bool> deleteCategory(int id) async {
    try {
      await _apiClient.delete('/categories/$id');
      return true;
    } catch (e) {
      _logger.e('Failed to delete category from remote source: $e');
      return false;
    }
  }
} 