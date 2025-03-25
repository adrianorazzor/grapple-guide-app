import 'package:result_dart/result_dart.dart';

import '../api/i_video_repository.dart';
import '../dtos/video_dto.dart';
import '../models/video.dart';

class VideoService {
  final IVideoRepository _remoteRepository;
  final IVideoRepository _localRepository;
  
  VideoService(this._remoteRepository, this._localRepository);
  
  // Get all videos
  Future<Result<List<Video>>> getVideos({int? categoryId}) async {
    try {
      // First try to get from remote
      final dtos = await _remoteRepository.getVideos(categoryId: categoryId);
      
      if (dtos.isNotEmpty) {
        // Cache the results locally if implemented
        // await _cacheVideos(dtos);
        
        // Transform DTOs to domain models
        return Success(dtos.toModelList());
      }
      
      // If remote fails, try local
      final localDtos = await _localRepository.getVideos(categoryId: categoryId);
      return Success(localDtos.toModelList());
    } catch (e) {
      return Failure(Exception('Failed to fetch videos: $e'));
    }
  }
  
  // Get a single video by ID
  Future<Result<Video>> getVideo(int id) async {
    try {
      // First try to get from remote
      final dto = await _remoteRepository.getVideo(id);
      
      if (dto != null) {
        // Cache the result locally if implemented
        // await _cacheVideo(dto);
        
        // Transform DTO to domain model
        return Success(dto.toModel());
      }
      
      // If remote fails, try local
      final localDto = await _localRepository.getVideo(id);
      
      if (localDto != null) {
        return Success(localDto.toModel());
      }
      
      return Failure(Exception('Video not found'));
    } catch (e) {
      return Failure(Exception('Failed to fetch video: $e'));
    }
  }
  
  // Create a new video
  Future<Result<Video>> createVideo(Video video) async {
    try {
      // Convert domain model to DTO
      final dto = VideoDTO(
        id: video.id,
        title: video.title,
        categoryId: video.categoryId,
        description: video.description,
        videoUrl: video.videoUrl,
        thumbnailUrl: video.thumbnailUrl,
        instructor: video.instructor,
        isFavorite: video.isFavorite,
        notes: video.notes,
        durationInSeconds: video.duration.inSeconds,
      );
      
      // Create in remote
      final createdDto = await _remoteRepository.createVideo(dto);
      
      if (createdDto != null) {
        // Cache the result locally if implemented
        // await _localRepository.createVideo(createdDto);
        
        // Transform DTO to domain model
        return Success(createdDto.toModel());
      }
      
      return Failure(Exception('Failed to create video'));
    } catch (e) {
      return Failure(Exception('Failed to create video: $e'));
    }
  }
  
  // Update an existing video
  Future<Result<Video>> updateVideo(Video video) async {
    try {
      // Convert domain model to DTO
      final dto = VideoDTO(
        id: video.id,
        title: video.title,
        categoryId: video.categoryId,
        description: video.description,
        videoUrl: video.videoUrl,
        thumbnailUrl: video.thumbnailUrl,
        instructor: video.instructor,
        isFavorite: video.isFavorite,
        notes: video.notes,
        durationInSeconds: video.duration.inSeconds,
      );
      
      // Update in remote
      final updatedDto = await _remoteRepository.updateVideo(dto);
      
      if (updatedDto != null) {
        // Update locally if implemented
        // await _localRepository.updateVideo(updatedDto);
        
        // Transform DTO to domain model
        return Success(updatedDto.toModel());
      }
      
      return Failure(Exception('Failed to update video'));
    } catch (e) {
      return Failure(Exception('Failed to update video: $e'));
    }
  }
  
  // Delete a video
  Future<Result<Unit>> deleteVideo(int id) async {
    try {
      // Delete from remote
      final success = await _remoteRepository.deleteVideo(id);
      
      if (success) {
        // Delete locally if implemented
        // await _localRepository.deleteVideo(id);
        
        return Success(unit);
      }
      
      return Failure(Exception('Failed to delete video'));
    } catch (e) {
      return Failure(Exception('Failed to delete video: $e'));
    }
  }
  
  // Toggle favorite status
  Future<Result<Video>> toggleFavorite(int id) async {
    try {
      // First get the video
      final getResult = await getVideo(id);
      
      if (getResult.isSuccess()) {
        final video = getResult.getOrThrow();
        
        // Convert domain model to DTO
        final dto = VideoDTO(
          id: video.id,
          title: video.title,
          categoryId: video.categoryId,
          description: video.description,
          videoUrl: video.videoUrl,
          thumbnailUrl: video.thumbnailUrl,
          instructor: video.instructor,
          isFavorite: video.isFavorite,
          notes: video.notes,
          durationInSeconds: video.duration.inSeconds,
        );
        
        // Toggle in remote
        final updatedDto = await _remoteRepository.toggleFavorite(dto);
        
        if (updatedDto != null) {
          // Update locally if implemented
          // await _localRepository.toggleFavorite(dto);
          
          // Transform DTO to domain model
          return Success(updatedDto.toModel());
        }
      }
      
      return Failure(Exception('Failed to toggle favorite status'));
    } catch (e) {
      return Failure(Exception('Failed to toggle favorite status: $e'));
    }
  }
  
  // Update video notes
  Future<Result<Video>> updateNotes(int id, String notes) async {
    try {
      // Update notes in remote
      final updatedDto = await _remoteRepository.updateNotes(id, notes);
      
      if (updatedDto != null) {
        // Update locally if implemented
        // await _localRepository.updateNotes(id, notes);
        
        // Transform DTO to domain model
        return Success(updatedDto.toModel());
      }
      
      return Failure(Exception('Failed to update notes'));
    } catch (e) {
      return Failure(Exception('Failed to update notes: $e'));
    }
  }
} 