// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_from_rakuten.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseFromRakuten _$$_ResponseFromRakutenFromJson(
        Map<String, dynamic> json) =>
    _$_ResponseFromRakuten(
      items: (json['Items'] as List<dynamic>)
          .map((e) => BookData.fromJson(e as Map<String, dynamic>))
          .toList(),
      hits: json['hits'] as int,
    );

Map<String, dynamic> _$$_ResponseFromRakutenToJson(
        _$_ResponseFromRakuten instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'hits': instance.hits,
    };
