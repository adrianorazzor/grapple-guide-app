import 'package:equatable/equatable.dart';

import '../../models/category.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final int? selectedCategoryId;
  
  const CategoryLoaded({
    required this.categories, 
    this.selectedCategoryId,
  });
  
  @override
  List<Object?> get props => [categories, selectedCategoryId];
  
  CategoryLoaded copyWith({
    List<Category>? categories,
    int? selectedCategoryId,
    bool clearSelectedCategory = false,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      selectedCategoryId: clearSelectedCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
    );
  }
}

class CategoryError extends CategoryState {
  final String message;
  
  const CategoryError(this.message);
  
  @override
  List<Object> get props => [message];
}

class SingleCategoryLoaded extends CategoryState {
  final Category category;
  
  const SingleCategoryLoaded(this.category);
  
  @override
  List<Object> get props => [category];
} 