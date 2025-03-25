// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryDTO _$CategoryDTOFromJson(Map<String, dynamic> json) => _CategoryDTO(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  videoCount: (json['videoCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$CategoryDTOToJson(_CategoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'videoCount': instance.videoCount,
    };
