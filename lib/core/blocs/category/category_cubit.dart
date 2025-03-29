import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_service.dart';
import '../../services/video_service.dart';
import 'category_state.dart';
import '../../models/category.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _categoryService;
  final VideoService? _videoService; // Make video service optional to maintain backward compatibility
  
  CategoryCubit({
    required CategoryService categoryService, 
    VideoService? videoService,
  }) : _categoryService = categoryService,
       _videoService = videoService,
       super(CategoryInitial());
  
  Future<void> loadCategories() async {
    emit(CategoryLoading());
    
    final result = await _categoryService.getCategories();
    
    result.fold(
      (categories) => emit(CategoryLoaded(categories: categories)),
      (error) => emit(CategoryError(error.toString())),
    );
  }
  
  Future<void> loadCategory(int id) async {
    emit(CategoryLoading());
    
    final result = await _categoryService.getCategory(id);
    
    result.fold(
      (category) => emit(SingleCategoryLoaded(category)),
      (error) => emit(CategoryError(error.toString())),
    );
  }
  
  Future<void> createCategory(Category category) async {
    emit(CategoryLoading());
    
    final result = await _categoryService.createCategory(category);
    
    result.fold(
      (createdCategory) async {
        // Reload the categories to include the new one
        await loadCategories();
      },
      (error) => emit(CategoryError(error.toString())),
    );
  }
  
  Future<void> updateCategoryWithVideoCount() async {
    // Only proceed if we have access to the video service
    if (_videoService == null) return;
    
    final currentState = state;
    if (currentState is CategoryLoaded) {
      final updatedCategories = List.of(currentState.categories);
      
      // For each category, get the videos and update the count
      for (int i = 0; i < updatedCategories.length; i++) {
        final category = updatedCategories[i];
        final videosResult = await _videoService.getVideos(categoryId: category.id);
        
        videosResult.fold(
          (videos) {
            // Update category with correct video count
            updatedCategories[i] = category.copyWith(videoCount: videos.length);
          },
          (_) {} // Ignore errors for now
        );
      }
      
      // Emit updated state with correct video counts
      emit(CategoryLoaded(
        categories: updatedCategories,
        selectedCategoryId: currentState.selectedCategoryId,
      ));
    }
  }
  
  void selectCategory(int categoryId) {
    final currentState = state;
    
    if (currentState is CategoryLoaded) {
      emit(currentState.copyWith(selectedCategoryId: categoryId));
    }
  }
} 