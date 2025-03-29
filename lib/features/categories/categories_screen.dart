import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../core/blocs/category/category_cubit.dart';
import '../../core/blocs/category/category_state.dart';
import '../../core/models/category.dart';
import 'category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load categories when the screen builds
    _loadCategories(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('BJJ Categories'),
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh categories',
            onPressed: () => _refreshCategories(context),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to Favorites in future enhancement
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Favorites coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/categories/add'),
        tooltip: 'Add Category',
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return _buildCategoriesList(context, state.categories);
          } else if (state is CategoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadCategories(context),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Select a category to view videos'));
          }
        },
      ),
    );
  }

  void _loadCategories(BuildContext context) {
    context.read<CategoryCubit>().loadCategories();
  }

  void _refreshCategories(BuildContext context) {
    // First refresh the basic category data
    _loadCategories(context);
    
    // Capture the BuildContext to avoid "use_build_context_synchronously" warning
    final CategoryCubit cubit = context.read<CategoryCubit>();
    
    // Update video counts for each category
    Future.delayed(const Duration(seconds: 1), () {
      cubit.updateCategoryWithVideoCount();
    });
  }

  Widget _buildCategoriesList(BuildContext context, List<Category> categories) {
    if (categories.isEmpty) {
      return const Center(
        child: Text('No categories found'),
      );
    }

    // Determine if we're on Windows (desktop) or mobile
    final bool isDesktop = kIsWeb || (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    
    // Screen width to calculate appropriate grid
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Adjust grid based on platform and screen width
    int crossAxisCount = 2; // Default for mobile
    double childAspectRatio = 1.0; // Default aspect ratio
    
    if (isDesktop) {
      // For desktop, use more columns based on screen width
      if (screenWidth > 1200) {
        crossAxisCount = 5;
        childAspectRatio = 0.8;
      } else if (screenWidth > 800) {
        crossAxisCount = 4;
        childAspectRatio = 0.85;
      } else {
        crossAxisCount = 3;
        childAspectRatio = 0.9;
      }
    } else {
      // For mobile, adjust based on orientation
      if (screenWidth > 600) {
        crossAxisCount = 3;
        childAspectRatio = 0.9;
      }
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryCard(
          category: category,
          onTap: () {
            // Update the selected category
            context.go('/categories/${category.id}');
          },
        );
      },
    );
  }
} 