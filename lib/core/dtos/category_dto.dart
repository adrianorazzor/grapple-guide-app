import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/category.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
abstract class CategoryDTO with _$CategoryDTO {
  const factory CategoryDTO({
    required int id,
    required String name,
    String? description,
    String? imageUrl,
    int? videoCount,
  }) = _CategoryDTO;

  factory CategoryDTO.fromJson(Map<String, dynamic> json) => _$CategoryDTOFromJson(json);
}

// Extension to convert DTO to domain model
extension CategoryDTOMapper on CategoryDTO {
  Category toModel() {
    return Category(
      id: id,
      name: name,
      description: description ?? '',
      imageUrl: imageUrl ?? '',
      videoCount: videoCount ?? 0,
    );
  }
}

// Extension to convert a list of DTOs to a list of domain models
extension CategoryDTOListMapper on List<CategoryDTO> {
  List<Category> toModelList() {
    return map((dto) => dto.toModel()).toList();
  }
} 