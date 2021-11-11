// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// other file
import '../widgets/library_card.dart';
import '../utils/configurations.dart';
import '../utils/empty_space.dart';

final isAdLoadedProvider =
    StateNotifierProvider.autoDispose<IsAdLoadedNotifier, bool>(
        (_) => IsAdLoadedNotifier());

class IsAdLoadedNotifier extends StateNotifier<bool> {
  IsAdLoadedNotifier() : super(false);

  void changeState() => state = !state;
}

final nativeAdProvider = Provider.autoDispose<AdWidget>((ref) {
  final NativeAdListener listener = NativeAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      ref.read(isAdLoadedProvider.notifier).changeState();
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
  );

  final NativeAd myNative = NativeAd(
    adUnitId: Platform.isAndroid ? nativeAdIdAndroid : nativeAdIdIOS,
    factoryId: 'loadingScreen',
    request: AdRequest(),
    listener: listener,
  );

  ref.onDispose(() => myNative.dispose());

  myNative.load();
  return AdWidget(ad: myNative);
});

class ResultScreen extends HookWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showLibrary = useProvider(getLibraryProvider);
    final _size = MediaQuery.of(context).size;
    final _nativeAdWidget = useProvider(nativeAdProvider);
    final _isAdLoaded = useProvider(isAdLoadedProvider);

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: _showLibrary.when(
          data: (_) => Text('検索結果'),
          loading: () => Text(''),
          error: (_, stack) => Text('検索結果'),
        ),
      ),
      body: SafeArea(
        child: _showLibrary.when(
          data: (libs) => libs == null
              ? Center(
                  child: Text('キャンセル'),
                )
              : libs.isEmpty
                  ? Center(
                      child: Text('周辺の図書館にはありませんでした。'),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: libs.map((lib) {
                              print(lib.distance);
                              return LibraryCard(lib: lib);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
          loading: () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitPouringHourGlassRefined(
                  size: 100, color: Theme.of(context).iconTheme.color!),
              addVerticalEmptySpace(20),
              Text('検索中...', style: Theme.of(context).textTheme.headline5),
              addVerticalEmptySpace(10),
              Text('少し時間がかかる場合がございます。'),
              addVerticalEmptySpace(20),
              Container(
                alignment: Alignment.center,
                child:
                    _isAdLoaded ? _nativeAdWidget : CircularProgressIndicator(),
                width: _size.width / 1.5,
                height: _size.height / 3,
              ),
            ],
          ),
          error: (err, stack) => Center(
            //child: Text('エラーが発生しました。時間をおいて再度お試しください。'),
            child: Text(err.toString()),
          ),
        ),
      ),
    );
  }
}
