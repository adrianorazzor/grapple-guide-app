import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/blocs/video/video_cubit.dart';
import '../../core/blocs/video/video_state.dart';
import '../../core/models/video.dart';

class AddVideoScreen extends StatefulWidget {
  final int categoryId;

  const AddVideoScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  final _thumbnailUrlController = TextEditingController();
  final _instructorController = TextEditingController();
  final _durationController = TextEditingController();
  
  bool _isSubmitting = false;
  bool _showThumbnailPreview = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    _thumbnailUrlController.dispose();
    _instructorController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Video'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/categories/${widget.categoryId}'),
        ),
      ),
      body: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) {
          if (state is VideoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isSubmitting = false;
            });
          } else if (state is VideoLoaded || state is SingleVideoLoaded) {
            // Video was successfully added
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Video added successfully'),
                backgroundColor: Colors.green,
              ),
            );
            // Navigate back to videos list
            context.go('/categories/${widget.categoryId}');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title field
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title *',
                    hintText: 'Enter video title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Description field
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter video description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                
                // URL field
                TextFormField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'Video URL *',
                    hintText: 'Enter video URL (YouTube, Vimeo, etc.)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a video URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Thumbnail URL field
                TextFormField(
                  controller: _thumbnailUrlController,
                  decoration: InputDecoration(
                    labelText: 'Thumbnail URL',
                    hintText: 'Enter thumbnail image URL',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showThumbnailPreview ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _showThumbnailPreview = !_showThumbnailPreview;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Thumbnail preview
                if (_showThumbnailPreview && _thumbnailUrlController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _thumbnailUrlController.text,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Text('Invalid image URL'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                
                // Instructor field
                TextFormField(
                  controller: _instructorController,
                  decoration: const InputDecoration(
                    labelText: 'Instructor',
                    hintText: 'Enter instructor name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Duration field
                TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (seconds)',
                    hintText: 'Enter video duration in seconds',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                
                // Submit button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Add Video'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Parse duration (default to 0 if not valid)
      final int duration = int.tryParse(_durationController.text.trim()) ?? 0;

      // Create a new video using a temporary ID (-1)
      // The backend will assign the proper ID
      final newVideo = Video(
        id: -1, // Temporary ID
        title: _titleController.text.trim(),
        categoryId: widget.categoryId,
        description: _descriptionController.text.trim(),
        url: _urlController.text.trim(),
        thumbnailUrl: _thumbnailUrlController.text.trim(),
        instructor: _instructorController.text.trim(),
        durationSeconds: duration,
        isFavorite: false,
        notes: '',
      );

      // Call cubit to add video
      context.read<VideoCubit>().createVideo(newVideo);
    }
  }
} 