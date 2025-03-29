import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/video_service.dart';
import '../category/category_cubit.dart';
import '../category/category_state.dart';
import '../../models/video.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoService _videoService;
  final CategoryCubit _categoryCubit;
  
  VideoCubit({
    required VideoService videoService,
    required CategoryCubit categoryCubit,
  }) : _videoService = videoService,
       _categoryCubit = categoryCubit,
       super(VideoInitial());
  
  Future<void> loadVideos() async {
    emit(VideoLoading());
    
    int? categoryId;
    if (_categoryCubit.state is CategoryLoaded) {
      categoryId = (_categoryCubit.state as CategoryLoaded).selectedCategoryId;
    }
    
    final result = await _videoService.getVideos(categoryId: categoryId);
    
    result.fold(
      (videos) => emit(VideoLoaded(videos)),
      (error) => emit(VideoError(error.toString())),
    );
  }
  
  Future<void> loadVideo(int id) async {
    emit(VideoLoading());
    
    final result = await _videoService.getVideo(id);
    
    result.fold(
      (video) => emit(SingleVideoLoaded(video)),
      (error) => emit(VideoError(error.toString())),
    );
  }
  
  Future<void> createVideo(Video video) async {
    emit(VideoLoading());
    
    final result = await _videoService.createVideo(video);
    
    result.fold(
      (createdVideo) async {
        // Reload the videos to include the new one
        await loadVideos();
      },
      (error) => emit(VideoError(error.toString())),
    );
  }
  
  Future<void> loadFavoriteVideos() async {
    emit(VideoLoading());
    
    final result = await _videoService.getVideos();
    
    result.fold(
      (videos) {
        final favoriteVideos = videos.where((video) => video.isFavorite).toList();
        emit(FavoriteVideosLoaded(favoriteVideos));
      },
      (error) => emit(VideoError(error.toString())),
    );
  }
  
  Future<void> toggleFavorite(int id) async {
    emit(VideoLoading());
    
    final result = await _videoService.toggleFavorite(id);
    
    result.fold(
      (video) => emit(SingleVideoLoaded(video)),
      (error) => emit(VideoError(error.toString())),
    );
  }
  
  int? getCategoryId() {
    if (_categoryCubit.state is CategoryLoaded) {
      return (_categoryCubit.state as CategoryLoaded).selectedCategoryId;
    }
    return null;
  }
} 