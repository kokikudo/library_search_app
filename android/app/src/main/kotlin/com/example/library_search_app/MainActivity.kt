package com.example.library_search_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

class MainActivity : FlutterActivity() {

    ///日本記事を見ながらAndroid側のUIの実装は完了。
    // flutter側でUIを取得したWidgetの作成をする。

    // flutter側で定義したFactoryIDとNativeAdFactoryを紐付け
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        flutterEngine.plugins.add(GoogleMobileAdsPlugin());
//        super.configureFlutterEngine(flutterEngine)
//
//        GoogleMobileAdsPlugin.registerNativeAdFactory(
//                flutterEngine,
//                "adFactoryKokiKudo", // Factory ID
//                NativeAdFactory(layoutInflater) // NativeAdFactoryクラス
//        )
//    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "loadingScreen",
                LoadingScreenNativeAdFactory(context)
        )
    }

    // アプリ終了時に広告を削除
    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
                flutterEngine, "loadingScreen"
        )
    }
}
