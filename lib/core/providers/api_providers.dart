import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/category_repository.dart';
import '../api/video_repository.dart';

// API Client provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// Category Repository provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CategoryRepository(apiClient);
});

// Video Repository provider
final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return VideoRepository(apiClient);
}); 