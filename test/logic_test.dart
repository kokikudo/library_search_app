import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_search_app/models/freezed_models/library.dart';
import 'package:library_search_app/models/freezed_models/libraryHasBookData.dart';
import 'package:library_search_app/utils/configurations.dart';
import 'package:library_search_app/models/freezed_models/show_library.dart';

const isbn = '4834000826';

Future<LibraryHasBookData> _get(
    {String? session,
    String? systemIdQuery,
    String? isbn,
    String? apiKey,
    required CancelToken token}) async {
  // DioでAPIにリクエスト
  const url = 'https://api.calil.jp/check';
  // query設定。nullではない値が設定される。
  final Map<String, Object?> queryParameters = {
    'callback': 'no',
    if (systemIdQuery != null) 'systemid': systemIdQuery,
    if (isbn != null) 'isbn': isbn,
    if (apiKey != null) 'appkey': apiKey,
    if (session != null) 'session': session,
  };
  final result = await Dio()
      .get<Map<String, Object?>>(url, queryParameters: queryParameters);
  // モデル化して返却
  return LibraryHasBookData.fromJson(result.data!);
}

Future<List<Library>> _getLibFromPosition() async {
  const latitude = '136.7163027';
  const longitude = '35.390516';

  // DioでAPIにリクエスト
  const url = 'https://api.calil.jp/library';
  final Map<String, Object?> queryParameters = {
    'callback': '',
    'format': 'json',
    'geocode': '$latitude,$longitude',
    'limit': searchLibraryCount,
    'appkey': calilApiKey
  };
  final response =
      await Dio().get<List<dynamic>>(url, queryParameters: queryParameters);

  return response.data!
      .map((bookData) => Library.fromJson(bookData as Map<String, dynamic>))
      .toList();
}

String _getSystemIdQuery(List<Library> libs) {
  return libs
      .map((lib) {
        return lib.systemid;
      })
      .toList()
      .toSet()
      .toList()
      .join(',');
}

Future<LibraryHasBookData> _getResponseHasBook(
    String systemIdQuery, String isbn, CancelToken token) async {
  var response = await _get(
      systemIdQuery: systemIdQuery,
      isbn: isbn,
      apiKey: calilApiKey,
      token: token);

  while (response.isOK == 1) {
    print('continue = 1 のため再取得開始');
    await Future.delayed(const Duration(seconds: 3));
    response = await _get(session: response.session, token: token);
  }
  return response;
}

void main() {
  test('位置情報から図書館データ取得', () async {
    final result = await _getLibFromPosition();
    for (var lib in result) {
      print(lib);
      print('-------');
    }
  });

  test('システムIDのクエリ取得', () async {
    final result = await _getLibFromPosition();
    final idList = _getSystemIdQuery(result);
    print(idList);
  });

  test('表示させる図書館を取得', () async {
    final libraries = await _getLibFromPosition();
    final idList = _getSystemIdQuery(libraries);
    final token = CancelToken();
    final result = await _getResponseHasBook(idList, isbn, token);

    print(result.session);

    List<ShowLibrary> showLibraries = _getShowLibrary(result, libraries);
    for (var lib in showLibraries) {
      print('''
       --------------
       ${lib.name}:
       ${lib.address}:
       ${lib.post}:
       ${lib.bookPageUrl}:
       ${lib.status}:
       ${lib.geocode}:
       ${lib.category}:
       ${lib.distance}:
       ''');
    }
  });
}

List<ShowLibrary> _getShowLibrary(
    LibraryHasBookData result, List<Library> libraries) {
  // 最終的に表示させる図書館のモデルリスト
  List<ShowLibrary> showLibraries = [];
  // データの中身
  final bookData = result.books[isbn] as Map<String, dynamic>;
  // 各データをもとにモデルを作成しリストに追加する
  bookData.forEach((systemId, value) {
    // {'図書館' : '貸出可'}
    final Map<String, dynamic>? libkey = value['libkey'];

    // 管理情報がある図書館のみに絞り込む
    if (libkey != null && libkey.isNotEmpty) {
      libkey.forEach((libName, status) {
        final url = value['reserveurl'];
        // システムIDとlibkeyが一致した時にモデル作成、リストに追加。
        final showLibData = libraries
            .where((lib) => lib.systemid == systemId && lib.libkey == libName)
            .map(
              (lib) => ShowLibrary(
                name: lib.formal,
                address: lib.address,
                post: lib.post,
                status: status,
                category: lib.category,
                distance: lib.distance,
                geocode: lib.geocode,
                bookPageUrl: url,
              ),
            );
        showLibraries.addAll(showLibData);
      });
    }
  });
  return showLibraries;
}
