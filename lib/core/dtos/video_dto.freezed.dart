// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoDTO {

 int get id; String get title; int get categoryId; String? get description; String? get url; String? get thumbnailUrl; String? get instructor; bool? get isFavorite; String? get notes; int? get durationInSeconds;
/// Create a copy of VideoDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoDTOCopyWith<VideoDTO> get copyWith => _$VideoDTOCopyWithImpl<VideoDTO>(this as VideoDTO, _$identity);

  /// Serializes this VideoDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.durationInSeconds, durationInSeconds) || other.durationInSeconds == durationInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryId,description,url,thumbnailUrl,instructor,isFavorite,notes,durationInSeconds);

@override
String toString() {
  return 'VideoDTO(id: $id, title: $title, categoryId: $categoryId, description: $description, url: $url, thumbnailUrl: $thumbnailUrl, instructor: $instructor, isFavorite: $isFavorite, notes: $notes, durationInSeconds: $durationInSeconds)';
}


}

/// @nodoc
abstract mixin class $VideoDTOCopyWith<$Res>  {
  factory $VideoDTOCopyWith(VideoDTO value, $Res Function(VideoDTO) _then) = _$VideoDTOCopyWithImpl;
@useResult
$Res call({
 int id, String title, int categoryId, String? description, String? url, String? thumbnailUrl, String? instructor, bool? isFavorite, String? notes, int? durationInSeconds
});




}
/// @nodoc
class _$VideoDTOCopyWithImpl<$Res>
    implements $VideoDTOCopyWith<$Res> {
  _$VideoDTOCopyWithImpl(this._self, this._then);

  final VideoDTO _self;
  final $Res Function(VideoDTO) _then;

/// Create a copy of VideoDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? categoryId = null,Object? description = freezed,Object? url = freezed,Object? thumbnailUrl = freezed,Object? instructor = freezed,Object? isFavorite = freezed,Object? notes = freezed,Object? durationInSeconds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,durationInSeconds: freezed == durationInSeconds ? _self.durationInSeconds : durationInSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _VideoDTO implements VideoDTO {
  const _VideoDTO({required this.id, required this.title, required this.categoryId, this.description, this.url, this.thumbnailUrl, this.instructor, this.isFavorite, this.notes, this.durationInSeconds});
  factory _VideoDTO.fromJson(Map<String, dynamic> json) => _$VideoDTOFromJson(json);

@override final  int id;
@override final  String title;
@override final  int categoryId;
@override final  String? description;
@override final  String? url;
@override final  String? thumbnailUrl;
@override final  String? instructor;
@override final  bool? isFavorite;
@override final  String? notes;
@override final  int? durationInSeconds;

/// Create a copy of VideoDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoDTOCopyWith<_VideoDTO> get copyWith => __$VideoDTOCopyWithImpl<_VideoDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.instructor, instructor) || other.instructor == instructor)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.durationInSeconds, durationInSeconds) || other.durationInSeconds == durationInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,categoryId,description,url,thumbnailUrl,instructor,isFavorite,notes,durationInSeconds);

@override
String toString() {
  return 'VideoDTO(id: $id, title: $title, categoryId: $categoryId, description: $description, url: $url, thumbnailUrl: $thumbnailUrl, instructor: $instructor, isFavorite: $isFavorite, notes: $notes, durationInSeconds: $durationInSeconds)';
}


}

/// @nodoc
abstract mixin class _$VideoDTOCopyWith<$Res> implements $VideoDTOCopyWith<$Res> {
  factory _$VideoDTOCopyWith(_VideoDTO value, $Res Function(_VideoDTO) _then) = __$VideoDTOCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, int categoryId, String? description, String? url, String? thumbnailUrl, String? instructor, bool? isFavorite, String? notes, int? durationInSeconds
});




}
/// @nodoc
class __$VideoDTOCopyWithImpl<$Res>
    implements _$VideoDTOCopyWith<$Res> {
  __$VideoDTOCopyWithImpl(this._self, this._then);

  final _VideoDTO _self;
  final $Res Function(_VideoDTO) _then;

/// Create a copy of VideoDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? categoryId = null,Object? description = freezed,Object? url = freezed,Object? thumbnailUrl = freezed,Object? instructor = freezed,Object? isFavorite = freezed,Object? notes = freezed,Object? durationInSeconds = freezed,}) {
  return _then(_VideoDTO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,instructor: freezed == instructor ? _self.instructor : instructor // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: freezed == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,durationInSeconds: freezed == durationInSeconds ? _self.durationInSeconds : durationInSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
