// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  id: json['id'] as String,
  title: json['title'] as String,
  categoryId: json['categoryId'] as String,
  description: json['description'] as String? ?? '',
  videoUrl: json['videoUrl'] as String? ?? '',
  thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
  instructor: json['instructor'] as String? ?? '',
  isFavorite: json['isFavorite'] as bool? ?? false,
  notes: json['notes'] as String? ?? '',
  duration:
      json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['duration'] as num).toInt()),
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryId': instance.categoryId,
  'description': instance.description,
  'videoUrl': instance.videoUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'instructor': instance.instructor,
  'isFavorite': instance.isFavorite,
  'notes': instance.notes,
  'duration': instance.duration.inMicroseconds,
};
