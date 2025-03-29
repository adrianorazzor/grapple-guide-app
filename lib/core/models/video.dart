import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@Freezed(copyWith: true)
abstract class Video with _$Video {
  factory Video({
    required int id,
    required String title,
    required int categoryId,
    @Default('') String description,
    @Default('') String url,
    @Default('') String thumbnailUrl,
    @Default('') String instructor,
    @Default(false) bool isFavorite,
    @Default('') String notes,
    @Default(0) int durationSeconds,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
} 