// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
// models
import '../models/freezed_models/book.dart';
// other file
import '../screens/home.dart';
import '../screens/result.dart';
import '../utils/constraints.dart';
import '../main.dart';
import '../utils/empty_space.dart';
import 'library_card.dart';

class ButtonInShowBookWidget extends HookWidget {
  const ButtonInShowBookWidget({
    Key? key,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  final IconData iconData;
  final String label;

  Future<void> _showBookInfoAlert(Book book, BuildContext context, bool isLight,
      TextTheme textTheme) async {
    const _calilPageURL = 'https://calil.jp/book/';
    final _size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('本の詳細'),
            backgroundColor: isLight ? kcBeige : kcBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SizedBox(
              height: _size.height / 2,
              width: _size.width / 2,
              child: ListView(
                children: [
                  Text('タイトル', style: textTheme.caption),
                  Text('${book.title} ${book.subTitle}'),
                  addVerticalEmptySpace(20),
                  Text('著者', style: textTheme.caption),
                  Text(book.author),
                  addVerticalEmptySpace(20),
                  Text('発売日', style: textTheme.caption),
                  Text(book.salesDate),
                  addVerticalEmptySpace(20),
                  Text('出版社', style: textTheme.caption),
                  Text(book.publisherName),
                  addVerticalEmptySpace(20),
                  Text('説明', style: textTheme.caption),
                  Text(book.itemCaption),
                  addVerticalEmptySpace(20),
                  OutlinedButton(
                    onPressed: () => launch(_calilPageURL + book.isbn),
                    child: const Text('さらに本の詳細を見る'),
                    style: OutlinedButton.styleFrom(
                      primary: isLight ? kcBrown : kcLightBlue,
                      side: BorderSide(
                        color: isLight ? kcBrown : kcLightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final _showBook = useProvider(showBookProvider);
    final _textTheme = Theme.of(context).textTheme;
    final _isLightTheme = useProvider(isLightThemeProvider);
    final _buttonStyle = NeumorphicTheme.of(context)!.current!.buttonStyle!;
    return NeumorphicButton(
        child: Column(
          children: [
            Icon(iconData),
            Text(label, style: _textTheme.button),
          ],
        ),
        padding: const EdgeInsets.all(20),
        style: _buttonStyle.copyWith(
          color: _isLightTheme ? kcBeige : kcBlue,
        ),
        onPressed: () {
          if (iconData == Icons.library_books) {
            _showBookInfoAlert(_showBook, context, _isLightTheme, _textTheme);
          } else {
            context.read(isbnProvider.notifier).changeState(_showBook.isbn);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResultScreen(),
              ),
            );
          }
        });
  }
}