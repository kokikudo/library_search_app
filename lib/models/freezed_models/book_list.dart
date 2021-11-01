import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'book.dart';

part 'book_list.freezed.dart';
part 'book_list.g.dart';

@freezed
class BookList with _$BookList {
  factory BookList({
    required int totalCount, // 取得件数
    required List<Book> books, // データ
}) = _BookList;

 factory BookList.fromJson(Map<String, dynamic> json) => _$BookListFromJson(json);
}