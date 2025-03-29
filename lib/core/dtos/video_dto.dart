import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/video.dart';

part 'video_dto.freezed.dart';
part 'video_dto.g.dart';

@freezed
abstract class VideoDTO with _$VideoDTO {
  const factory VideoDTO({
    required int id,
    required String title,
    required int categoryId,
    String? description,
    String? url,
    String? thumbnailUrl,
    String? instructor,
    bool? isFavorite,
    String? notes,
    int? durationInSeconds,
  }) = _VideoDTO;

  factory VideoDTO.fromJson(Map<String, dynamic> json) => _$VideoDTOFromJson(json);
}

// Extension to convert DTO to domain model
extension VideoDTOMapper on VideoDTO {
  Video toModel() {
    return Video(
      id: id,
      title: title,
      categoryId: categoryId,
      description: description ?? '',
      url: url ?? '',
      thumbnailUrl: thumbnailUrl ?? '',
      instructor: instructor ?? '',
      isFavorite: isFavorite ?? false,
      notes: notes ?? '',
      durationSeconds: durationInSeconds ?? 0,
    );
  }
}

// Extension to convert a list of DTOs to a list of domain models
extension VideoDTOListMapper on List<VideoDTO> {
  List<Video> toModelList() {
    return map((dto) => dto.toModel()).toList();
  }
} 