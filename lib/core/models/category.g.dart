// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: const IdConverter().fromJson(json['id']),
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  imageUrl: json['imageUrl'] as String? ?? '',
  videoCount: (json['videoCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'name': instance.name,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'videoCount': instance.videoCount,
};
