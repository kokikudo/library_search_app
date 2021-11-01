import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_data.freezed.dart';
part 'book_data.g.dart';

// レスポンスのシリアルデータモデル
@freezed
class BookData with _$BookData {
  factory BookData({@JsonKey(name: 'Item') required Map<String, Object?> item}) = _BookData;

  factory BookData.fromJson(Map<String, Object?> json) => _$BookDataFromJson(json);
}