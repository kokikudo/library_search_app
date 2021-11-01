// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookList _$$_BookListFromJson(Map<String, dynamic> json) => _$_BookList(
      totalCount: json['totalCount'] as int,
      books: (json['books'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BookListToJson(_$_BookList instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'books': instance.books,
    };
