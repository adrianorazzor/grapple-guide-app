import '../dtos/video_dto.dart';
import 'api_client.dart';
import '../logger/app_logger.dart';
import 'i_video_repository.dart';

class RemoteVideoRepository implements IVideoRepository {
  final ApiClient _apiClient;
  final AppLogger _logger = AppLogger();
  
  RemoteVideoRepository(this._apiClient);
  
  @override
  Future<List<VideoDTO>> getVideos({int? categoryId}) async {
    try {
      String path = '/videos';
      
      if (categoryId != null) {
        path += '?categoryId=$categoryId';
      }
      
      final response = await _apiClient.get(path);
      
      if (response is List) {
        return response
            .map((json) => VideoDTO.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      return [];
    } catch (e) {
      _logger.e('Failed to fetch videos from remote source: $e');
      return [];
    }
  }
  
  @override
  Future<VideoDTO?> getVideo(int id) async {
    try {
      final response = await _apiClient.get('/videos/$id');
      return VideoDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to fetch video from remote source: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> createVideo(VideoDTO video) async {
    try {
      final response = await _apiClient.post(
        '/videos',
        data: video.toJson(),
      );
      return VideoDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to create video on remote source: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> updateVideo(VideoDTO video) async {
    try {
      final response = await _apiClient.put(
        '/videos/${video.id}',
        data: video.toJson(),
      );
      return VideoDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to update video on remote source: $e');
      return null;
    }
  }
  
  @override
  Future<bool> deleteVideo(int id) async {
    try {
      await _apiClient.delete('/videos/$id');
      return true;
    } catch (e) {
      _logger.e('Failed to delete video from remote source: $e');
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
      _logger.e('Failed to toggle favorite status of video on remote source: $e');
      return null;
    }
  }
  
  @override
  Future<VideoDTO?> updateNotes(int id, String notes) async {
    try {
      final response = await _apiClient.put(
        '/videos/$id/notes',
        data: {'notes': notes},
      );
      return VideoDTO.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Failed to update notes on remote source: $e');
      return null;
    }
  }
} 