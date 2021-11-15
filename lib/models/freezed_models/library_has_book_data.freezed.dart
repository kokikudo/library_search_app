// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'library_has_book_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LibraryHasBookData _$LibraryHasBookDataFromJson(Map<String, dynamic> json) {
  return _LibraryHasBookData.fromJson(json);
}

/// @nodoc
class _$LibraryHasBookDataTearOff {
  const _$LibraryHasBookDataTearOff();

  _LibraryHasBookData call(
      {required String session,
      required Map<String, dynamic> books,
      @JsonKey(name: 'continue') required int isOK}) {
    return _LibraryHasBookData(
      session: session,
      books: books,
      isOK: isOK,
    );
  }

  LibraryHasBookData fromJson(Map<String, Object> json) {
    return LibraryHasBookData.fromJson(json);
  }
}

/// @nodoc
const $LibraryHasBookData = _$LibraryHasBookDataTearOff();

/// @nodoc
mixin _$LibraryHasBookData {
  String get session => throw _privateConstructorUsedError;
  Map<String, dynamic> get books => throw _privateConstructorUsedError;
  @JsonKey(name: 'continue')
  int get isOK => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LibraryHasBookDataCopyWith<LibraryHasBookData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibraryHasBookDataCopyWith<$Res> {
  factory $LibraryHasBookDataCopyWith(
          LibraryHasBookData value, $Res Function(LibraryHasBookData) then) =
      _$LibraryHasBookDataCopyWithImpl<$Res>;
  $Res call(
      {String session,
      Map<String, dynamic> books,
      @JsonKey(name: 'continue') int isOK});
}

/// @nodoc
class _$LibraryHasBookDataCopyWithImpl<$Res>
    implements $LibraryHasBookDataCopyWith<$Res> {
  _$LibraryHasBookDataCopyWithImpl(this._value, this._then);

  final LibraryHasBookData _value;
  // ignore: unused_field
  final $Res Function(LibraryHasBookData) _then;

  @override
  $Res call({
    Object? session = freezed,
    Object? books = freezed,
    Object? isOK = freezed,
  }) {
    return _then(_value.copyWith(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isOK: isOK == freezed
          ? _value.isOK
          : isOK // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$LibraryHasBookDataCopyWith<$Res>
    implements $LibraryHasBookDataCopyWith<$Res> {
  factory _$LibraryHasBookDataCopyWith(
          _LibraryHasBookData value, $Res Function(_LibraryHasBookData) then) =
      __$LibraryHasBookDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String session,
      Map<String, dynamic> books,
      @JsonKey(name: 'continue') int isOK});
}

/// @nodoc
class __$LibraryHasBookDataCopyWithImpl<$Res>
    extends _$LibraryHasBookDataCopyWithImpl<$Res>
    implements _$LibraryHasBookDataCopyWith<$Res> {
  __$LibraryHasBookDataCopyWithImpl(
      _LibraryHasBookData _value, $Res Function(_LibraryHasBookData) _then)
      : super(_value, (v) => _then(v as _LibraryHasBookData));

  @override
  _LibraryHasBookData get _value => super._value as _LibraryHasBookData;

  @override
  $Res call({
    Object? session = freezed,
    Object? books = freezed,
    Object? isOK = freezed,
  }) {
    return _then(_LibraryHasBookData(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as String,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isOK: isOK == freezed
          ? _value.isOK
          : isOK // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LibraryHasBookData
    with DiagnosticableTreeMixin
    implements _LibraryHasBookData {
  _$_LibraryHasBookData(
      {required this.session,
      required this.books,
      @JsonKey(name: 'continue') required this.isOK});

  factory _$_LibraryHasBookData.fromJson(Map<String, dynamic> json) =>
      _$$_LibraryHasBookDataFromJson(json);

  @override
  final String session;
  @override
  final Map<String, dynamic> books;
  @override
  @JsonKey(name: 'continue')
  final int isOK;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LibraryHasBookData(session: $session, books: $books, isOK: $isOK)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LibraryHasBookData'))
      ..add(DiagnosticsProperty('session', session))
      ..add(DiagnosticsProperty('books', books))
      ..add(DiagnosticsProperty('isOK', isOK));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LibraryHasBookData &&
            (identical(other.session, session) ||
                const DeepCollectionEquality()
                    .equals(other.session, session)) &&
            (identical(other.books, books) ||
                const DeepCollectionEquality().equals(other.books, books)) &&
            (identical(other.isOK, isOK) ||
                const DeepCollectionEquality().equals(other.isOK, isOK)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(session) ^
      const DeepCollectionEquality().hash(books) ^
      const DeepCollectionEquality().hash(isOK);

  @JsonKey(ignore: true)
  @override
  _$LibraryHasBookDataCopyWith<_LibraryHasBookData> get copyWith =>
      __$LibraryHasBookDataCopyWithImpl<_LibraryHasBookData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LibraryHasBookDataToJson(this);
  }
}

abstract class _LibraryHasBookData implements LibraryHasBookData {
  factory _LibraryHasBookData(
      {required String session,
      required Map<String, dynamic> books,
      @JsonKey(name: 'continue') required int isOK}) = _$_LibraryHasBookData;

  factory _LibraryHasBookData.fromJson(Map<String, dynamic> json) =
      _$_LibraryHasBookData.fromJson;

  @override
  String get session => throw _privateConstructorUsedError;
  @override
  Map<String, dynamic> get books => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'continue')
  int get isOK => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LibraryHasBookDataCopyWith<_LibraryHasBookData> get copyWith =>
      throw _privateConstructorUsedError;
}
