// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoDTO _$VideoDTOFromJson(Map<String, dynamic> json) => _VideoDTO(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  categoryId: (json['categoryId'] as num).toInt(),
  description: json['description'] as String?,
  url: json['url'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  instructor: json['instructor'] as String?,
  isFavorite: json['isFavorite'] as bool?,
  notes: json['notes'] as String?,
  durationInSeconds: (json['durationInSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$VideoDTOToJson(_VideoDTO instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryId': instance.categoryId,
  'description': instance.description,
  'url': instance.url,
  'thumbnailUrl': instance.thumbnailUrl,
  'instructor': instance.instructor,
  'isFavorite': instance.isFavorite,
  'notes': instance.notes,
  'durationInSeconds': instance.durationInSeconds,
};
