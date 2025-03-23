import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import 'api_providers.dart';

// Provider to fetch all categories
final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategories();
});

// Provider to fetch a single category by ID
final categoryProvider = FutureProvider.family.autoDispose<Category, String>((ref, id) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategory(id);
});

// Selected category provider (for active category in UI)
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null); 