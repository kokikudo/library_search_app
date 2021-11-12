// package
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// freezed
import '../models/freezed_models/book.dart';
import '../models/freezed_models/book_list.dart';
import '../models/freezed_models/response_from_rakuten.dart';
// other file
import '../screens/home.dart';
import '../utils/configurations.dart';
import 'show_book_widget.dart';

class TitleSearchBar extends HookWidget {
  const TitleSearchBar({
    Key? key,
  }) : super(key: key);

  // 候補の本をモデル化して返却
  Future<BookList> _getBooks(String title) async {
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
    final response = await Dio()
        .get<Map<String, Object?>>(url, queryParameters: queryParameters);
    final responseModel = ResponseFromRakuten.fromJson(response.data!);
    final books = BookList(
      totalCount: responseModel.hits, // ヒットした件数
      books: responseModel.items // 個別にモデル化
          .map(
            (bookData) => Book.fromJson(bookData.item),
          )
          .toList(growable: false), // リストにしてそれをモデル化
    );
    return books;
  }

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController();
    final _focusNude = useFocusNode();
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -5,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10),
        ),
      ),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _controller,
          keyboardType: TextInputType.name,
          focusNode: _focusNude,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _controller.clear();
                _focusNude.requestFocus();
              }
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(20.0),
          ),
        ),
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),

        // 候補を取得
        suggestionsCallback: (title) async {
          // 空白の時は空白のTextを返す
          if (title.isEmpty) {
            return [Text('')];
          }

          // 取得
          final bookList = await _getBooks(title);

          // データの中身を返す
          return bookList.books;
        },

        // 候補をWidgetにして表示
        itemBuilder: (_, bookData) {
          // 空白の場合は空白Textを返す
          if (bookData is Text) {
            return Text('');
          }

          // 型を指定しListTileとして表示
          final book = bookData as Book;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(book.title),
            ),
          );
        },

        errorBuilder: (_, err) => Text(err.toString()),
        transitionBuilder: (context, suggestionsBox, _) => suggestionsBox,

        // どれかタップされたら表示する本のプロバイダーshowBookProviderのStateを更新する
        onSuggestionSelected: (bookData) {
          if (bookData is Text) {
            return;
          }
          final book = bookData as Book;
          // 表示する本の情報を更新
          context
              .read(showBookProvider.notifier)
              .changeState(book);
        },
      ),
    );
  }
}
