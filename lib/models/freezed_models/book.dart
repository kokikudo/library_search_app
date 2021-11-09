import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

// 本のデータモデル
// "Items"["Item"]のなかの各キーを取得する
@freezed
class Book with _$Book {
  factory Book({
    required String title,
    required String subTitle,
    required String author,
    required String isbn,
    required String salesDate,
    required String publisherName,
    required String itemCaption,
    required String largeImageUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);
}
