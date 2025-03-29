// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  categoryId: (json['categoryId'] as num).toInt(),
  description: json['description'] as String? ?? '',
  url: json['url'] as String? ?? '',
  thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
  instructor: json['instructor'] as String? ?? '',
  isFavorite: json['isFavorite'] as bool? ?? false,
  notes: json['notes'] as String? ?? '',
  durationSeconds: (json['durationSeconds'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'categoryId': instance.categoryId,
  'description': instance.description,
  'url': instance.url,
  'thumbnailUrl': instance.thumbnailUrl,
  'instructor': instance.instructor,
  'isFavorite': instance.isFavorite,
  'notes': instance.notes,
  'durationSeconds': instance.durationSeconds,
};
