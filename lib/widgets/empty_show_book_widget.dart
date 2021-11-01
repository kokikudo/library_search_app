import 'package:flutter_hooks/flutter_hooks.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:library_search_app/utils/constraints.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/empty_space.dart';

class EmptyShowBookWidget extends HookWidget {
  const EmptyShowBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLightTheme = useProvider(isLightThemeProvider);
    return Neumorphic(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: Image.asset(
                'assets/bookImage.png',
                color: _isLightTheme ? kcDarkBeige : kcLightBlue,
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                  '本のタイトルから調べたい本を検索できます。\nバーコード検索(本の背面にある978から始まる番号のバーコード)もできます。'),
            ),
          ],
        ),
      ),
    );
  }
}
