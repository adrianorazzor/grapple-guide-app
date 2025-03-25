import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/category_service.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryService _categoryService;
  
  CategoryCubit({required CategoryService categoryService}) 
      : _categoryService = categoryService,
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
  
  void selectCategory(int categoryId) {
    final currentState = state;
    
    if (currentState is CategoryLoaded) {
      emit(currentState.copyWith(selectedCategoryId: categoryId));
    }
  }
} 