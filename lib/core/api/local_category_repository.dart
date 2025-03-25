import '../dtos/category_dto.dart';
import '../logger/app_logger.dart';
import 'i_category_repository.dart';

class LocalCategoryRepository implements ICategoryRepository {
  final AppLogger _logger = AppLogger();
  
  LocalCategoryRepository();
  
  @override
  Future<List<CategoryDTO>> getCategories() async {
    try {
      return [];
    } catch (e) {
      _logger.e('Failed to fetch categories from local storage: $e');
      return [];
    }
  }
  
  @override
  Future<CategoryDTO?> getCategory(int id) async {
    try {
      return null;
    } catch (e) {
      _logger.e('Failed to fetch category from local storage: $e');
      return null;
    }
  }
  
  @override
  Future<CategoryDTO?> createCategory(CategoryDTO category) async {
    try {
      return category;
    } catch (e) {
      _logger.e('Failed to create category in local storage: $e');
      return null;
    }
  }
  
  @override
  Future<CategoryDTO?> updateCategory(CategoryDTO category) async {
    try {
      return category;
    } catch (e) {
      _logger.e('Failed to update category in local storage: $e');
      return null;
    }
  }
  
  @override
  Future<bool> deleteCategory(int id) async {
    try {
      return true;
    } catch (e) {
      _logger.e('Failed to delete category from local storage: $e');
      return false;
    }
  }
} 