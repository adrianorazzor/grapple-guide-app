import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/blocs/video/video_cubit.dart';
import '../../core/blocs/video/video_state.dart';
import '../../core/models/video.dart';

class VideoDetailsScreen extends StatefulWidget {
  final int videoId;

  const VideoDetailsScreen({
    super.key,
    required this.videoId,
  });

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  final TextEditingController _notesController = TextEditingController();
  bool _isEditingNotes = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  void _loadVideo() {
    context.read<VideoCubit>().loadVideo(widget.videoId);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<VideoCubit, VideoState>(
          builder: (context, state) {
            if (state is SingleVideoLoaded) {
              return Text(state.video.title);
            } else {
              return const Text('Video Details');
            }
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            final categoryId = context.read<VideoCubit>().getCategoryId();
            if (categoryId != null) {
              context.go('/categories/$categoryId');
            } else {
              context.go('/categories');
            }
          },
        ),
        actions: [
          BlocBuilder<VideoCubit, VideoState>(
            builder: (context, state) {
              if (state is SingleVideoLoaded) {
                return IconButton(
                  icon: Icon(
                    state.video.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: state.video.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => _toggleFavorite(state.video.id),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SingleVideoLoaded) {
            return _buildVideoDetails(context, state.video);
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
                    'Error loading video',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadVideo,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Video not found'),
            );
          }
        },
      ),
    );
  }

  Widget _buildVideoDetails(BuildContext context, Video video) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video thumbnail/preview
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: video.thumbnailUrl.isNotEmpty
                  ? Image.network(
                      video.thumbnailUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildThumbnailPlaceholder(),
                    )
                  : _buildThumbnailPlaceholder(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Video title
          Text(
            video.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          const SizedBox(height: 8),
          
          // Metadata
          if (video.instructor.isNotEmpty)
            _buildInfoRow(Icons.person, 'Instructor: ${video.instructor}'),
          
          _buildInfoRow(Icons.timer, 'Duration: ${_formatDuration(video.duration)}'),
          
          const SizedBox(height: 16),
          
          // Description
          if (video.description.isNotEmpty) ...[
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              video.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
          ],
          
          // Notes section
          _buildNotesSection(video),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(Video video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Notes',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (!_isEditingNotes)
              TextButton.icon(
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit'),
                onPressed: () {
                  setState(() {
                    _isEditingNotes = true;
                    _notesController.text = video.notes;
                  });
                },
              )
            else
              TextButton.icon(
                icon: const Icon(Icons.save, size: 16),
                label: const Text('Save'),
                onPressed: () => _saveNotes(video.id),
              ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        if (_isEditingNotes)
          TextField(
            controller: _notesController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Add your notes here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              video.notes.isEmpty
                  ? 'No notes yet. Tap Edit to add your notes.'
                  : video.notes,
            ),
          ),
      ],
    );
  }

  Widget _buildThumbnailPlaceholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          Icons.play_circle_outline,
          size: 60,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  void _toggleFavorite(int id) {
    context.read<VideoCubit>().toggleFavorite(id);
  }

  void _saveNotes(int id) {
    setState(() {
      _isEditingNotes = false;
    });
  }
} 