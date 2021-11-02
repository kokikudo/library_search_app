import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'library.freezed.dart';
part 'library.g.dart';

@freezed
class Library with _$Library {
  //@JsonKey(name: 'Items') required
  factory Library({
    required String systemid,
    required String systemname,
    required String libkey,
    required String libid,
    required String short,
    required String formal,
    required String address,
    required String post,
    required String geocode,
    required String category,
    required double distance,
}) = _Library;

 factory Library.fromJson(Map<String, dynamic> json) => _$LibraryFromJson(json);
}