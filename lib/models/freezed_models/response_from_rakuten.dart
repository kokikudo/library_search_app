import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'book_data.dart';

part 'response_from_rakuten.freezed.dart';
part 'response_from_rakuten.g.dart';

@freezed
class ResponseFromRakuten with _$ResponseFromRakuten {
  factory ResponseFromRakuten({@JsonKey(name: 'Items') required List<BookData> items, required int hits}) = _ResponseFromRakuten;

 factory ResponseFromRakuten.fromJson(Map<String, Object?> json) => _$ResponseFromRakutenFromJson(json);
}