import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/video.dart';
import '../../core/providers/category_providers.dart';
import '../../core/providers/video_providers.dart';
import 'video_list_item.dart';

class VideosScreen extends ConsumerWidget {
  final String categoryId;

  const VideosScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Set the selected category ID in the provider
    ref.read(selectedCategoryIdProvider.notifier).state = categoryId;
    
    // Watch for the current category details
    final categoryAsync = ref.watch(categoryProvider(categoryId));
    
    // Watch for videos in this category
    final videosAsync = ref.watch(videosProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: categoryAsync.when(
          data: (category) => Text(category.name),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Videos'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality in future enhancement
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      body: videosAsync.when(
        data: (videos) => _buildVideosList(context, videos),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
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
                'Error loading videos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(videosProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideosList(BuildContext context, List<Video> videos) {
    if (videos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videocam_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No videos in this category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: videos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final video = videos[index];
        return VideoListItem(
          video: video,
          onTap: () => context.go('/videos/${video.id}'),
        );
      },
    );
  }
} 