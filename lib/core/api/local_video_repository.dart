import '../dtos/video_dto.dart';
import '../logger/app_logger.dart';
import 'i_video_repository.dart';

class LocalVideoRepository implements IVideoRepository {
  final AppLogger _logger = AppLogger();
  
  LocalVideoRepository();
  
  @override
  Future<List<VideoDTO>> getVideos({int? categoryId}) async {
    try {
      return [];
    } catch (e) {
      _logger.e('Failed to fetch videos from local storage: $e');
      return [];
    }
  }
  
  @override
  Future<VideoDTO?> getVideo(int id) async {
    try {
      return null;
    } catch (e) {
      _logger.e('Failed to fetch video from local storage: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> createVideo(VideoDTO video) async {
    try {
      return video;
    } catch (e) {
      _logger.e('Failed to create video in local storage: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> updateVideo(VideoDTO video) async {
    try {
      return video;
    } catch (e) {
      _logger.e('Failed to update video in local storage: $e');
      return null;
    }
  }
  
  @override
  Future<bool> deleteVideo(int id) async {
    try {
      return true;
    } catch (e) {
      _logger.e('Failed to delete video from local storage: $e');
      return false;
    }
  }
  
  @override
  Future<VideoDTO?> toggleFavorite(VideoDTO video) async {
    try {
      final updatedVideo = video.copyWith(
        isFavorite: !(video.isFavorite ?? false),
      );
      
      return await updateVideo(updatedVideo);
    } catch (e) {
      _logger.e('Failed to toggle favorite status of video in local storage: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> updateNotes(int id, String notes) async {
    try {
      return null;
    } catch (e) {
      _logger.e('Failed to update notes in local storage: $e');
      return null;
    }
  }
} 