import '../dtos/category_dto.dart';

abstract class ICategoryRepository {
  Future<List<CategoryDTO>> getCategories();
  
  Future<CategoryDTO?> getCategory(int id);
  
  Future<CategoryDTO?> createCategory(CategoryDTO category);
  
  Future<CategoryDTO?> updateCategory(CategoryDTO category);
  
  Future<bool> deleteCategory(int id);
} 