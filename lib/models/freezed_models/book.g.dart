// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      author: json['author'] as String,
      isbn: json['isbn'] as String,
      salesDate: json['salesDate'] as String,
      publisherName: json['publisherName'] as String,
      itemCaption: json['itemCaption'] as String,
      largeImageUrl: json['largeImageUrl'] as String,
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'author': instance.author,
      'isbn': instance.isbn,
      'salesDate': instance.salesDate,
      'publisherName': instance.publisherName,
      'itemCaption': instance.itemCaption,
      'largeImageUrl': instance.largeImageUrl,
    };
