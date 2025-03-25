import '../dtos/video_dto.dart';

abstract class IVideoRepository {
  Future<List<VideoDTO>> getVideos({int? categoryId});
  
  Future<VideoDTO?> getVideo(int id);
  
  Future<VideoDTO?> createVideo(VideoDTO video);
  
  Future<VideoDTO?> updateVideo(VideoDTO video);
  
  Future<bool> deleteVideo(int id);
  
  Future<VideoDTO?> toggleFavorite(VideoDTO video);
  
  Future<VideoDTO?> updateNotes(int id, String notes);
} 