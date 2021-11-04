// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
// freezed
import '../models/freezed_models/book.dart';
// other file
import '../screens/home.dart';
import '../utils/constraints.dart';
import '../main.dart';

final textEditingControllerProvider =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

class TitleSearchBar extends HookWidget {
  const TitleSearchBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _isLightTheme = useProvider(isLightThemeProvider);
    final _response = useProvider(getBooksProvider);
    final _controller = useProvider(textEditingControllerProvider);
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
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: _isLightTheme ? kcBrown : kcWhite,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _controller.clear(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(20.0),
          ),
        ),
        // サジェスト処理
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isLightTheme ? kcBeige : kcBlue,
        ),
        suggestionsCallback: (getTitle) async {
          getTitle = _controller.text;
          if (getTitle.length < 2) {
            return [Text('')];
          }

          await context.read(getBooksProvider.notifier).getBooks(getTitle);
          return _response!.books;
        },
        errorBuilder: (_, err) => Text(err.toString()),
        itemBuilder: (_, bookData) {
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
        transitionBuilder: (context, suggestionsBox, _) => suggestionsBox,
        onSuggestionSelected: (bookData) {
          if (bookData is Text) {
            return;
          }
          final book = bookData as Book;
          // 表示する本の情報を更新
          context
              .read(showBookProvider.notifier)
              .changeState(book.title, book.isbn, book.largeImageUrl);
        },
      ),
    );
  }
}
