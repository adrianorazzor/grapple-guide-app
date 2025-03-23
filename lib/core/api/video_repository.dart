import '../models/video.dart';
import 'api_client.dart';

class VideoRepository {
  final ApiClient _apiClient;
  
  VideoRepository(this._apiClient);
  
  // Get all videos
  Future<List<Video>> getVideos({String? categoryId}) async {
    try {
      final queryParams = categoryId != null ? {'categoryId': categoryId} : null;
      final response = await _apiClient.get('/videos', queryParameters: queryParams);
      
      if (response is List) {
        return response
            .map((json) => Video.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      return [];
    } catch (e) {
      throw 'Failed to fetch videos: $e';
    }
  }
  
  // Get a single video by ID
  Future<Video> getVideo(String id) async {
    try {
      final response = await _apiClient.get('/videos/$id');
      return Video.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to fetch video: $e';
    }
  }
  
  // Create a new video
  Future<Video> createVideo(Video video) async {
    try {
      final response = await _apiClient.post(
        '/videos',
        data: video.toJson(),
      );
      return Video.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to create video: $e';
    }
  }
  
  // Update an existing video
  Future<Video> updateVideo(Video video) async {
    try {
      final response = await _apiClient.put(
        '/videos/${video.id}',
        data: video.toJson(),
      );
      return Video.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to update video: $e';
    }
  }
  
  // Delete a video
  Future<void> deleteVideo(String id) async {
    try {
      await _apiClient.delete('/videos/$id');
    } catch (e) {
      throw 'Failed to delete video: $e';
    }
  }
  
  // Toggle favorite status
  Future<Video> toggleFavorite(String id, bool isFavorite) async {
    try {
      final response = await _apiClient.put(
        '/videos/$id/favorite',
        data: {'isFavorite': isFavorite},
      );
      return Video.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to update favorite status: $e';
    }
  }
  
  // Update video notes
  Future<Video> updateNotes(String id, String notes) async {
    try {
      final response = await _apiClient.put(
        '/videos/$id/notes',
        data: {'notes': notes},
      );
      return Video.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to update notes: $e';
    }
  }
} 