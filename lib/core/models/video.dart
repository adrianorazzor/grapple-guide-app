import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@Freezed(copyWith: true)
abstract class Video with _$Video {
  factory Video({
    required String id,
    required String title,
    required String categoryId,
    @Default('') String description,
    @Default('') String videoUrl,
    @Default('') String thumbnailUrl,
    @Default('') String instructor,
    @Default(false) bool isFavorite,
    @Default('') String notes,
    @Default(Duration.zero) Duration duration,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
} 