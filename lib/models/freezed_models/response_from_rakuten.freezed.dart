// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'response_from_rakuten.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ResponseFromRakuten _$ResponseFromRakutenFromJson(Map<String, dynamic> json) {
  return _ResponseFromRakuten.fromJson(json);
}

/// @nodoc
class _$ResponseFromRakutenTearOff {
  const _$ResponseFromRakutenTearOff();

  _ResponseFromRakuten call(
      {@JsonKey(name: 'Items') required List<BookData> items,
      required int hits}) {
    return _ResponseFromRakuten(
      items: items,
      hits: hits,
    );
  }

  ResponseFromRakuten fromJson(Map<String, Object> json) {
    return ResponseFromRakuten.fromJson(json);
  }
}

/// @nodoc
const $ResponseFromRakuten = _$ResponseFromRakutenTearOff();

/// @nodoc
mixin _$ResponseFromRakuten {
  @JsonKey(name: 'Items')
  List<BookData> get items => throw _privateConstructorUsedError;
  int get hits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseFromRakutenCopyWith<ResponseFromRakuten> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseFromRakutenCopyWith<$Res> {
  factory $ResponseFromRakutenCopyWith(
          ResponseFromRakuten value, $Res Function(ResponseFromRakuten) then) =
      _$ResponseFromRakutenCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'Items') List<BookData> items, int hits});
}

/// @nodoc
class _$ResponseFromRakutenCopyWithImpl<$Res>
    implements $ResponseFromRakutenCopyWith<$Res> {
  _$ResponseFromRakutenCopyWithImpl(this._value, this._then);

  final ResponseFromRakuten _value;
  // ignore: unused_field
  final $Res Function(ResponseFromRakuten) _then;

  @override
  $Res call({
    Object? items = freezed,
    Object? hits = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
      hits: hits == freezed
          ? _value.hits
          : hits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ResponseFromRakutenCopyWith<$Res>
    implements $ResponseFromRakutenCopyWith<$Res> {
  factory _$ResponseFromRakutenCopyWith(_ResponseFromRakuten value,
          $Res Function(_ResponseFromRakuten) then) =
      __$ResponseFromRakutenCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'Items') List<BookData> items, int hits});
}

/// @nodoc
class __$ResponseFromRakutenCopyWithImpl<$Res>
    extends _$ResponseFromRakutenCopyWithImpl<$Res>
    implements _$ResponseFromRakutenCopyWith<$Res> {
  __$ResponseFromRakutenCopyWithImpl(
      _ResponseFromRakuten _value, $Res Function(_ResponseFromRakuten) _then)
      : super(_value, (v) => _then(v as _ResponseFromRakuten));

  @override
  _ResponseFromRakuten get _value => super._value as _ResponseFromRakuten;

  @override
  $Res call({
    Object? items = freezed,
    Object? hits = freezed,
  }) {
    return _then(_ResponseFromRakuten(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BookData>,
      hits: hits == freezed
          ? _value.hits
          : hits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ResponseFromRakuten
    with DiagnosticableTreeMixin
    implements _ResponseFromRakuten {
  _$_ResponseFromRakuten(
      {@JsonKey(name: 'Items') required this.items, required this.hits});

  factory _$_ResponseFromRakuten.fromJson(Map<String, dynamic> json) =>
      _$$_ResponseFromRakutenFromJson(json);

  @override
  @JsonKey(name: 'Items')
  final List<BookData> items;
  @override
  final int hits;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResponseFromRakuten(items: $items, hits: $hits)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResponseFromRakuten'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('hits', hits));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ResponseFromRakuten &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.hits, hits) ||
                const DeepCollectionEquality().equals(other.hits, hits)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(hits);

  @JsonKey(ignore: true)
  @override
  _$ResponseFromRakutenCopyWith<_ResponseFromRakuten> get copyWith =>
      __$ResponseFromRakutenCopyWithImpl<_ResponseFromRakuten>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ResponseFromRakutenToJson(this);
  }
}

abstract class _ResponseFromRakuten implements ResponseFromRakuten {
  factory _ResponseFromRakuten(
      {@JsonKey(name: 'Items') required List<BookData> items,
      required int hits}) = _$_ResponseFromRakuten;

  factory _ResponseFromRakuten.fromJson(Map<String, dynamic> json) =
      _$_ResponseFromRakuten.fromJson;

  @override
  @JsonKey(name: 'Items')
  List<BookData> get items => throw _privateConstructorUsedError;
  @override
  int get hits => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ResponseFromRakutenCopyWith<_ResponseFromRakuten> get copyWith =>
      throw _privateConstructorUsedError;
}
