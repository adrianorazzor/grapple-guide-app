import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';


@Freezed(copyWith: true)
abstract class Category with _$Category {
  factory Category({
    @JsonKey(name: 'id')
    required int id,
    required String name,
    @Default('') String description,
    @Default('') String imageUrl,
    @Default(0) int videoCount,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
} 