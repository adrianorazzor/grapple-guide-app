import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/blocs/category/category_cubit.dart';
import '../../core/blocs/category/category_state.dart';
import '../../core/blocs/video/video_cubit.dart';
import '../../core/blocs/video/video_state.dart';
import '../../core/models/video.dart';
import 'video_list_item.dart';

class VideosScreen extends StatelessWidget {
  final int categoryId;

  const VideosScreen({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // Set the selected category ID and load data when the screen builds
    _initData(context);
    
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is SingleCategoryLoaded) {
              return Text(state.category.name);
            } else {
              return const Text('Videos');
            }
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/categories'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/categories/$categoryId/add-video'),
        tooltip: 'Add Video',
        child: const Icon(Icons.video_call),
      ),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            return _buildVideosList(context, state.videos);
          } else if (state is VideoError) {
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
                    'Error loading videos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadVideos(context),
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

  void _initData(BuildContext context) {
    // Select the category and load videos when the screen is first built
    context.read<CategoryCubit>().selectCategory(categoryId);
    context.read<CategoryCubit>().loadCategory(categoryId);
    _loadVideos(context);
  }

  void _loadVideos(BuildContext context) {
    context.read<VideoCubit>().loadVideos();
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