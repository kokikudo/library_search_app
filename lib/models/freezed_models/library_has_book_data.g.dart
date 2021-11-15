// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_has_book_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LibraryHasBookData _$$_LibraryHasBookDataFromJson(
        Map<String, dynamic> json) =>
    _$_LibraryHasBookData(
      session: json['session'] as String,
      books: json['books'] as Map<String, dynamic>,
      isOK: json['continue'] as int,
    );

Map<String, dynamic> _$$_LibraryHasBookDataToJson(
        _$_LibraryHasBookData instance) =>
    <String, dynamic>{
      'session': instance.session,
      'books': instance.books,
      'continue': instance.isOK,
    };
