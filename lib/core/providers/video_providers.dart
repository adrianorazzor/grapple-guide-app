import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video.dart';
import 'api_providers.dart';
import 'category_providers.dart';

// Provider to fetch all videos
final videosProvider = FutureProvider.autoDispose<List<Video>>((ref) async {
  final repository = ref.watch(videoRepositoryProvider);
  final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
  
  if (selectedCategoryId != null) {
    return repository.getVideos(categoryId: selectedCategoryId);
  } else {
    return repository.getVideos();
  }
});

// Provider to fetch a single video by ID
final videoProvider = FutureProvider.family.autoDispose<Video, String>((ref, id) async {
  final repository = ref.watch(videoRepositoryProvider);
  return repository.getVideo(id);
});

// Provider for favorite videos
final favoriteVideosProvider = FutureProvider.autoDispose<List<Video>>((ref) async {
  final videos = await ref.watch(videosProvider.future);
  return videos.where((video) => video.isFavorite).toList();
});

// Provider to toggle a video's favorite status
final toggleFavoriteProvider = FutureProvider.family.autoDispose<Video, String>((ref, id) async {
  final repository = ref.watch(videoRepositoryProvider);
  final video = await repository.getVideo(id);
  return repository.toggleFavorite(id, !video.isFavorite);
}); 