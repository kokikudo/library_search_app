// models
import '../models/freezed_models/show_library.dart';
import '../models/freezed_models/libraryHasBookData.dart';
import '../models/freezed_models/library.dart';
// package
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
// apikey and searchLibraryCount
import '../utils/configurations.dart';

final dioProvider = Provider((_) => Dio());

class GetShowLibraryRepo {
  GetShowLibraryRepo(this._read, this._isbn, this._token);

  final Reader _read;
  final String _isbn;
  final CancelToken _token;
  late Position _position;
  late List<Library> _libList;
  late String _systemIdQuery;
  late LibraryHasBookData _completedLoadData;

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    _position = position;
  }

  Future<void> getLibFromPosition() async {
    final latitude = _position.latitude;
    final longitude = _position.longitude;

    const url = 'https://api.calil.jp/library';
    final Map<String, Object?> queryParameters = {
      'callback': '',
      'format': 'json',
      'geocode': '$longitude,$latitude',
      'limit': searchLibraryCount,
      'appkey': calilApiKey
    };
    final response = await _read(dioProvider)
        .get<List<dynamic>>(
      url,
      queryParameters: queryParameters,
      cancelToken: _token,
    )
        .catchError((cancel) {
      if (CancelToken.isCancel(cancel)) {
        print('周辺の図書館の検索を中断');
      } else {
        print('想定外のエラー');
      }
    });

    _libList = response.data!
        .map((bookData) => Library.fromJson(bookData as Map<String, dynamic>))
        .toList();
  }

  void _getSystemIdQuery() {
    _systemIdQuery = _libList
        .map((lib) {
          return lib.systemid;
        })
        .toList()
        .toSet()
        .toList()
        .join(',');
  }

  Future<void> getCompletedLoadHasBookData() async {
    _getSystemIdQuery();
    var response = await _getResponse(
      systemIdQuery: _systemIdQuery,
      isbn: _isbn,
      apiKey: calilApiKey,
    );

    while (response.isOK == 1) {
      print('再取得開始');
      await Future.delayed(const Duration(seconds: 3));
      response = await _getResponse(session: response.session);
    }
    _completedLoadData = response;
  }

  Future<LibraryHasBookData> _getResponse({
    String? session,
    String? systemIdQuery,
    String? isbn,
    String? apiKey,
  }) async {
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
    final result = await _read(dioProvider)
        .get<Map<String, Object?>>(
      url,
      queryParameters: queryParameters,
      cancelToken: _token,
    )
        .catchError((cancel) {
      if (CancelToken.isCancel(cancel)) {
        print('本の管理状況の取得を中断');
      } else {
        print('想定外のエラー');
      }
    });
    // モデル化して返却
    return LibraryHasBookData.fromJson(result.data!);
  }


  Future<List<ShowLibrary>> getShowLibrary() async {
    // 最終的に表示させる図書館のモデルリスト
    List<ShowLibrary> showLibraries = [];
    // データの中身
    final bookData = _completedLoadData.books[_isbn] as Map<String, dynamic>;
    // 各データをもとにモデルを作成しリストに追加する
    bookData.forEach((systemId, value) {
      // {'図書館' : '貸出可'}
      final Map<String, dynamic>? libkey = value['libkey'];

      // 管理情報がある図書館のみに絞り込む
      if (libkey != null && libkey.isNotEmpty) {
        libkey.forEach((libName, status) {
          final url = value['reserveurl'];
          // システムIDとlibkeyが一致した時にモデル作成、リストに追加。
          final showLibData = _libList
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
                  libPageUrl:
                      'https://calil.jp/library/search?s=${lib.systemid}&k=${lib.libkey}',
                ),
              );
          showLibraries.addAll(showLibData);
        });
      }
    });
    showLibraries.sort((a, b) => a.distance.compareTo(b.distance));
    return showLibraries;
  }
}
