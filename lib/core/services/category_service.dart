import 'package:result_dart/result_dart.dart';

import '../api/i_category_repository.dart';
import '../dtos/category_dto.dart';
import '../models/category.dart';

class CategoryService {
  final ICategoryRepository _remoteRepository;
  final ICategoryRepository _localRepository;
  
  CategoryService(this._remoteRepository, this._localRepository);
  
  Future<Result<List<Category>>> getCategories() async {
    try {
      final dtos = await _remoteRepository.getCategories();
      
      if (dtos.isNotEmpty) {
        // Cache the results locally if implemented
        // await _cacheCategories(dtos);
        
        return Success(dtos.toModelList());
      }
      
      // If remote fails, try local
      final localDtos = await _localRepository.getCategories();
      return Success(localDtos.toModelList());
    } catch (e) {
      return Failure(Exception('Failed to fetch categories: $e'));
    }
  }
  
  Future<Result<Category>> getCategory(int id) async {
    try {
      final dto = await _remoteRepository.getCategory(id);
      
      if (dto != null) {
        // Cache the result locally if implemented
        // await _cacheCategory(dto);
        
        return Success(dto.toModel());
      }
      
      final localDto = await _localRepository.getCategory(id);
      
      if (localDto != null) {
        return Success(localDto.toModel());
      }
      
      return Failure(Exception('Category not found'));
    } catch (e) {
      return Failure(Exception('Failed to fetch category: $e'));
    }
  }
  
  Future<Result<Category>> createCategory(Category category) async {
    try {
      final dto = CategoryDTO(
        id: category.id,
        name: category.name,
        description: category.description,
        imageUrl: category.imageUrl,
        videoCount: category.videoCount,
      );
      
      final createdDto = await _remoteRepository.createCategory(dto);
      
      if (createdDto != null) {
        // Cache the result locally if implemented
        // await _localRepository.createCategory(createdDto);
        
        return Success(createdDto.toModel());
      }
      
      return Failure(Exception('Failed to create category'));
    } catch (e) {
      return Failure(Exception('Failed to create category: $e'));
    }
  }
  
  Future<Result<Category>> updateCategory(Category category) async {
    try {
      final dto = CategoryDTO(
        id: category.id,
        name: category.name,
        description: category.description,
        imageUrl: category.imageUrl,
        videoCount: category.videoCount,
      );
      
      final updatedDto = await _remoteRepository.updateCategory(dto);
      
      if (updatedDto != null) {
        // Update locally if implemented
        // await _localRepository.updateCategory(updatedDto);
        
        return Success(updatedDto.toModel());
      }
      
      return Failure(Exception('Failed to update category'));
    } catch (e) {
      return Failure(Exception('Failed to update category: $e'));
    }
  }
  
  Future<Result<Unit>> deleteCategory(int id) async {
    try {
      final success = await _remoteRepository.deleteCategory(id);
      
      if (success) {
        // Delete locally if implemented
        // await _localRepository.deleteCategory(id);
        
        return Success(unit);
      }
      
      return Failure(Exception('Failed to delete category'));
    } catch (e) {
      return Failure(Exception('Failed to delete category: $e'));
    }
  }
} 