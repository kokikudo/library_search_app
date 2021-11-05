// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

//other file
import 'screens/home.dart';
import 'utils/constraints.dart';

final isLightThemeProvider = StateNotifierProvider<IsLightThemeNotifier, bool>(
    (_) => IsLightThemeNotifier());

class IsLightThemeNotifier extends StateNotifier<bool> {
  IsLightThemeNotifier() : super(true);

  void changeTheme() => state = !state;
}

///TODO
///カテゴリ実装
///スプラッシュスクリーン作成
///_element!.dirty: Bad stateの解決　＝＞質問中
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLightTheme = useProvider(isLightThemeProvider);
    return NeumorphicApp(
      title: 'Library Search App',
      debugShowCheckedModeBanner: false,
      themeMode: _isLightTheme ? ThemeMode.light : ThemeMode.dark,
      materialTheme: _buildTheme(_isLightTheme),
      materialDarkTheme: _buildTheme(_isLightTheme),
      theme: _buildNeumorphicTheme(_isLightTheme),
      darkTheme: _buildNeumorphicTheme(_isLightTheme),
      home: HomeScreen(),
    );
  }
}

ThemeData _buildTheme(bool isLight) {
  final primary = isLight ? kcBeige : kcBlue;
  final secondary = isLight ? kcBrown : kcWhite;
  final base = isLight ? ThemeData.light() : ThemeData.dark();
  return base.copyWith(
    scaffoldBackgroundColor: primary,
    iconTheme: base.iconTheme.copyWith(color: secondary),
    textSelectionTheme: base.textSelectionTheme
        .copyWith(cursorColor: secondary, selectionColor: secondary),
    textTheme: base.textTheme
        .copyWith()
        .apply(displayColor: secondary, bodyColor: secondary),
    chipTheme: base.chipTheme.copyWith(
        side: BorderSide(width: 1, color: secondary),
        backgroundColor: primary,
        //押されてない時の背景色
        disabledColor: Colors.grey,
        //無効時の背景色
        selectedColor: primary,
        //押されてる時の背景色
        checkmarkColor: secondary,
        //チェックマークの色
        secondarySelectedColor: secondary,
        //？
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        labelStyle: TextStyle(color: secondary),
        //押されてない時のラベル
        secondaryLabelStyle: TextStyle(color: primary),
        //?
        brightness: Brightness.light),
  );
}

NeumorphicThemeData _buildNeumorphicTheme(bool isLight) {
  final primary = isLight ? kcBeige : kcBlue;
  final secondary = isLight ? kcBrown : kcWhite;
  final base = isLight ? NeumorphicThemeData() : NeumorphicThemeData.dark();
  return base.copyWith(
    baseColor: primary,
    lightSource: LightSource.topLeft,
    iconTheme: base.iconTheme.copyWith(color: secondary),
    // ボタン以外のシェイプ
    boxShape: NeumorphicBoxShape.roundRect(
      BorderRadius.circular(30),
    ),
    depth: isLight ? 7 : 4,
    intensity: isLight ? 0.7 : 0.5,
    // ボタンのシェイプ
    buttonStyle: NeumorphicStyle(
      color: primary,
      shape: NeumorphicShape.convex,
      boxShape: NeumorphicBoxShape.stadium(),
      depth: isLight ? 7 : 4,
      intensity: isLight ? 0.7 : 0.5,
      lightSource: LightSource.topLeft,
    ),
    appBarTheme: NeumorphicAppBarThemeData(
      color: primary,
      textStyle: TextStyle(color: secondary, fontSize: 20.0),
      centerTitle: true,
    ),
  );
}
