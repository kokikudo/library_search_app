import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'show_library.freezed.dart';

@freezed
class ShowLibrary with _$ShowLibrary {
  factory ShowLibrary({
    required String name,
    required String address,
    required String post,
    required String status,
    required String category,
    required double distance,
    required String geocode,
    required String bookPageUrl,
    required String libPageUrl,
}) = _ShowLibrary;
}