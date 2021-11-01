import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_search_app/models/freezed_models/libraryHasBookData.dart';


const apiKey = 'AIzaSyCAsSKKnbVWfIcDd1F-DmVMgF0fWJSCt60';
const isbn = '4834000826';

Future<LibraryHasBookData> _get() async {

  // DioでAPIにリクエスト
  const url =
      'https://api.calil.jp/check';
  final Map<String, Object?> queryParameters = {
    'callback': 'no',
    'systemid': 'Aomori_Pref',
    'isbn': isbn,
    'appkey': apiKey
  };
  final result = await Dio().get<Map<String, Object?>>(url, queryParameters: queryParameters);
  // モデル化して返却
  return LibraryHasBookData.fromJson(result.data!);
}

void main() {
  test('本のタイトルを入れるとレスポンスがリストになって返ってくるか', () async {
    final result = await _get();
    print(result);
  });
}