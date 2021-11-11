// package
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

// other file
import '../main.dart';
import '../widgets/search_bar.dart';
import '../utils/empty_space.dart';
import '../utils/configurations.dart';
import '../utils/constraints.dart';
import '../widgets/empty_show_book_widget.dart';
import '../widgets/show_book_widget.dart';
import '../models/freezed_models/book.dart';

final showBookProvider =
    StateNotifierProvider<ShowBookNotifier, Book>((ref) => ShowBookNotifier());

class ShowBookNotifier extends StateNotifier<Book> {
  ShowBookNotifier()
      : super(
          Book(
              title: '',
              subTitle: '',
              author: '',
              isbn: '',
              salesDate: '',
              publisherName: '',
              itemCaption: '',
              largeImageUrl: ''),
        );

  changeState(newBook) => state = newBook;
}

final isBannerAdLoadedProvider =
    StateNotifierProvider.autoDispose<IsBannerAdLoadedNotifier, bool>(
        (_) => IsBannerAdLoadedNotifier());

class IsBannerAdLoadedNotifier extends StateNotifier<bool> {
  IsBannerAdLoadedNotifier() : super(false);

  void changeState() => state = true;
}

final bannerAdProvider = Provider.autoDispose<AdWidget>((ref) {
  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      ref.read(isBannerAdLoadedProvider.notifier).changeState();
      print('ad load completed');
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
  );

  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid ? bannerAdIdAndroid : bannerAdIdIOS,
    request: AdRequest(),
    listener: listener,
    size: AdSize.banner,
  );

  ref.onDispose(() => myBanner.dispose());

  myBanner.load();
  return AdWidget(ad: myBanner);
});

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showBook = useProvider(showBookProvider);
    final _isBannerAdLoaded = useProvider(isBannerAdLoadedProvider);
    final _bannerAdWidget = useProvider(bannerAdProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NeumorphicAppBar(
        title: Text('本を検索'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read(isLightThemeProvider.notifier).changeTheme(),
            icon: Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleSearchBar(),
              addVerticalEmptySpace(20),
              Expanded(
                child: _showBook.title.isEmpty
                    ? EmptyShowBookWidget()
                    : ShowBookWidget(),
              ),
              addVerticalEmptySpace(20),
              Container(
                width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: _isBannerAdLoaded
                      ? _bannerAdWidget
                      : CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
