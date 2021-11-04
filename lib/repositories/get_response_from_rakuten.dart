// models
import '../models/freezed_models/book.dart';
import '../models/freezed_models/response_from_rakuten.dart';
import '../models/freezed_models/book_list.dart';

// packages
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// apikey
import '../utils/configurations.dart';

// 補完機能のパッケージflutter_typeaheadとの相性が良くないのでProviderでの実装はせず普通の関数で実装した。
final dioProvider = Provider((_) => Dio());
final searchFromRakutenRepoProvider =
Provider((ref) => SearchFromRakutenRepo(ref.read));
final getBooksProvider = StateNotifierProvider<GetBooksNotifier, BookList?>(
        (ref) => GetBooksNotifier(ref.read));
class GetBooksNotifier extends StateNotifier<BookList?> {
  GetBooksNotifier(this._read) : super(null);

  final Reader _read;

  Future<void> getBooks(title) async {
    // 検索処理のプロバイダー
    final repo = _read(searchFromRakutenRepoProvider);
    // 検索
    final response = await repo.fetchBooks(title: title);

    state = response;
  }
}


class SearchFromRakutenRepo {
  SearchFromRakutenRepo(this._read);

  final Reader _read;

  // 取得
  Future<ResponseFromRakuten> _get(
      {required String title, CancelToken? cancelToken}) async {
    // DioでAPIにリクエスト
    const url =
        'https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404';
    final Map<String, Object?> queryParameters = {
      'format': 'json',
      'title': title,
      'size': 0,
      'booksGenreId': '001',
      'hits': 5,
      'applicationId': rakutenAPIkey
    };
    final result = await _read(dioProvider).get<Map<String, Object?>>(url,
        cancelToken: cancelToken, queryParameters: queryParameters);
    // モデル化して返却
    return ResponseFromRakuten.fromJson(result.data!);
  }

  Future<BookList> fetchBooks(
      {required String title, CancelToken? cancelToken}) async {
    final _response = await _get(title: title);
    final _result = BookList(
      totalCount: _response.hits,
      books: _response.items
          .map(
            (bookData) => Book.fromJson(bookData.item),
          )
          .toList(growable: false),
    );
    return _result;
  }
}
