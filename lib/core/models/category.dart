import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

// Handle conversion between int from backend and String in the app
class IdConverter implements JsonConverter<String, dynamic> {
  const IdConverter();
  
  @override
  String fromJson(dynamic id) {
    // Convert any id type (int, long, string) to String
    return id.toString();
  }
  
  @override
  dynamic toJson(String id) {
    // Try to convert to int if possible, otherwise keep as string
    return int.tryParse(id) ?? id;
  }
}

@Freezed(copyWith: true)
abstract class Category with _$Category {
  factory Category({
    @JsonKey(name: 'id')
    @IdConverter()
    required String id,
    required String name,
    @Default('') String description,
    @Default('') String imageUrl,
    @Default(0) int videoCount,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
} 