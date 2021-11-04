//Library
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// other file
import '../screens/home.dart';
import '../screens/result.dart';
import '../utils/constraints.dart';
import '../main.dart';
import 'library_card.dart';

class ShowBookWidget extends HookWidget {
  const ShowBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final _isLightTheme = useProvider(isLightThemeProvider);
    final _book = useProvider(showBookProvider);
    return Neumorphic(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 50),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 4,
              child: Image(
                image: NetworkImage(_book!.largeImageUrl),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NeumorphicButton(
                    child: Text(
                      '本の詳細を見る',
                      style: _textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                  Text('カーネル公式サイトへ移動',
                      style: _textTheme.caption, textAlign: TextAlign.end),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: NeumorphicButton(
                onPressed: () {
                  context
                      .read(isbnProvider.notifier)
                      .changeState(_book.isbn);
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
