//Library
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:library_search_app/models/freezed_models/book.dart';
import 'package:library_search_app/utils/empty_space.dart';

// other file
import '../screens/home.dart';
import '../screens/result.dart';
import '../utils/constraints.dart';
import '../main.dart';
import 'library_card.dart';



class ShowBookWidget extends HookWidget {
  const ShowBookWidget({
    Key? key, required this.book
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _isLightTheme = useProvider(isLightThemeProvider);
    // 表示する本のプロバイダー
    return Neumorphic(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 表示（画像のみ）
            Flexible(
              flex: 2,
              child: Image(
                image: NetworkImage(book.largeImageUrl),fit: BoxFit.contain,
              ),
            ),

            Flexible(
              flex: 1,
              child: NeumorphicButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '本の詳細を見る',
                      style: _textTheme.button
                    ),
                    addHorizonEmptySpace(10),
                    Icon(Icons.launch),
                  ],
                ),
                ///TODO 詳細ページに移動する処理
                onPressed: () {},
              ),
            ),
            Flexible(
              flex: 1,
              child: NeumorphicButton(
                onPressed: () {
                  context.read(isbnProvider.notifier).changeState(book.isbn);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(),
                    ),
                  );
                },
                child: Text('検索する',
                    style: _textTheme.button!.copyWith(
                      color: _isLightTheme ? kcBeige : kcBlue,
                    ),
                    textAlign: TextAlign.center),
                style:
                    NeumorphicTheme.of(context)!.current!.buttonStyle!.copyWith(
                          color: _isLightTheme ? kcBrown : kcLightBlue,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
