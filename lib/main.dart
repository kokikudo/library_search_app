// package
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

//other file
import 'screens/home.dart';
import 'utils/constraints.dart';
import 'utils/configurations.dart';

final isLightThemeProvider = StateNotifierProvider<IsLightThemeNotifier, bool>(
    (_) => IsLightThemeNotifier());

class IsLightThemeNotifier extends StateNotifier<bool> {
  IsLightThemeNotifier() : super(true);

  void changeTheme() => state = !state;
}

//53733D55-931D43F3-AEE7-1656F69DCA4B
///TODO スプラッシュスクリーン作成
void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, //縦固定
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.initialize(
    bannerAdUnitId: Platform.isAndroid ? bannerAdIdAndroid : bannerAdIdIOS,
    nativeAdUnitId:
        Platform.isAndroid ? nativeAdIdAndroid : nativeAdIdIOS,
  ); // Mobile Ads SDKの初期化
  MobileAds.setTestDeviceIds([
    '8a6f9f05-42fa-4441-865e-3b0e8aa5f02c',
    '53733D55-931D-43F3-AEE7-1656F69DCA4B'
  ]);

  await MobileAds.requestTrackingAuthorization();
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
