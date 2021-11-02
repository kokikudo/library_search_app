// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Library _$$_LibraryFromJson(Map<String, dynamic> json) => _$_Library(
      systemid: json['systemid'] as String,
      systemname: json['systemname'] as String,
      libkey: json['libkey'] as String,
      libid: json['libid'] as String,
      short: json['short'] as String,
      formal: json['formal'] as String,
      address: json['address'] as String,
      post: json['post'] as String,
      geocode: json['geocode'] as String,
      category: json['category'] as String,
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LibraryToJson(_$_Library instance) =>
    <String, dynamic>{
      'systemid': instance.systemid,
      'systemname': instance.systemname,
      'libkey': instance.libkey,
      'libid': instance.libid,
      'short': instance.short,
      'formal': instance.formal,
      'address': instance.address,
      'post': instance.post,
      'geocode': instance.geocode,
      'category': instance.category,
      'distance': instance.distance,
    };
