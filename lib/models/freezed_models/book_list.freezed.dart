// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'book_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookList _$BookListFromJson(Map<String, dynamic> json) {
  return _BookList.fromJson(json);
}

/// @nodoc
class _$BookListTearOff {
  const _$BookListTearOff();

  _BookList call({required int totalCount, required List<Book> books}) {
    return _BookList(
      totalCount: totalCount,
      books: books,
    );
  }

  BookList fromJson(Map<String, Object> json) {
    return BookList.fromJson(json);
  }
}

/// @nodoc
const $BookList = _$BookListTearOff();

/// @nodoc
mixin _$BookList {
  int get totalCount => throw _privateConstructorUsedError; // 取得件数
  List<Book> get books => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookListCopyWith<BookList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookListCopyWith<$Res> {
  factory $BookListCopyWith(BookList value, $Res Function(BookList) then) =
      _$BookListCopyWithImpl<$Res>;
  $Res call({int totalCount, List<Book> books});
}

/// @nodoc
class _$BookListCopyWithImpl<$Res> implements $BookListCopyWith<$Res> {
  _$BookListCopyWithImpl(this._value, this._then);

  final BookList _value;
  // ignore: unused_field
  final $Res Function(BookList) _then;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? books = freezed,
  }) {
    return _then(_value.copyWith(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc
abstract class _$BookListCopyWith<$Res> implements $BookListCopyWith<$Res> {
  factory _$BookListCopyWith(_BookList value, $Res Function(_BookList) then) =
      __$BookListCopyWithImpl<$Res>;
  @override
  $Res call({int totalCount, List<Book> books});
}

/// @nodoc
class __$BookListCopyWithImpl<$Res> extends _$BookListCopyWithImpl<$Res>
    implements _$BookListCopyWith<$Res> {
  __$BookListCopyWithImpl(_BookList _value, $Res Function(_BookList) _then)
      : super(_value, (v) => _then(v as _BookList));

  @override
  _BookList get _value => super._value as _BookList;

  @override
  $Res call({
    Object? totalCount = freezed,
    Object? books = freezed,
  }) {
    return _then(_BookList(
      totalCount: totalCount == freezed
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      books: books == freezed
          ? _value.books
          : books // ignore: cast_nullable_to_non_nullable
              as List<Book>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookList with DiagnosticableTreeMixin implements _BookList {
  _$_BookList({required this.totalCount, required this.books});

  factory _$_BookList.fromJson(Map<String, dynamic> json) =>
      _$$_BookListFromJson(json);

  @override
  final int totalCount;
  @override // 取得件数
  final List<Book> books;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BookList(totalCount: $totalCount, books: $books)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BookList'))
      ..add(DiagnosticsProperty('totalCount', totalCount))
      ..add(DiagnosticsProperty('books', books));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookList &&
            (identical(other.totalCount, totalCount) ||
                const DeepCollectionEquality()
                    .equals(other.totalCount, totalCount)) &&
            (identical(other.books, books) ||
                const DeepCollectionEquality().equals(other.books, books)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(totalCount) ^
      const DeepCollectionEquality().hash(books);

  @JsonKey(ignore: true)
  @override
  _$BookListCopyWith<_BookList> get copyWith =>
      __$BookListCopyWithImpl<_BookList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookListToJson(this);
  }
}

abstract class _BookList implements BookList {
  factory _BookList({required int totalCount, required List<Book> books}) =
      _$_BookList;

  factory _BookList.fromJson(Map<String, dynamic> json) = _$_BookList.fromJson;

  @override
  int get totalCount => throw _privateConstructorUsedError;
  @override // 取得件数
  List<Book> get books => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BookListCopyWith<_BookList> get copyWith =>
      throw _privateConstructorUsedError;
}
