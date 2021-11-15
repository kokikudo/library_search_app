import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_has_book_data.freezed.dart';

part 'library_has_book_data.g.dart';

@freezed
class LibraryHasBookData with _$LibraryHasBookData {
  factory LibraryHasBookData(
      {required String session,
      required Map<String, dynamic> books,
        @JsonKey(name: 'continue') required int isOK}) = _LibraryHasBookData;

  factory LibraryHasBookData.fromJson(Map<String, dynamic> json) =>
      _$LibraryHasBookDataFromJson(json);
}
