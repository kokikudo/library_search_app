// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_search_app/utils/empty_space.dart';

// other file
import '../widgets/library_card.dart';

enum ShowLibraryFilter {
  all,
  onlyRentable,
  rentableAnd5distance,
  rentableAnd10distance,
  only5distance,
  only10distance,
}

final showLibraryFilerProvider =
    StateNotifierProvider<ShowLibraryFilterNotifier, ShowLibraryFilter>(
        (_) => ShowLibraryFilterNotifier());

class ShowLibraryFilterNotifier extends StateNotifier<ShowLibraryFilter> {
  ShowLibraryFilterNotifier() : super(ShowLibraryFilter.all);

  void changeState(ShowLibraryFilter newCategory) => state = newCategory;
}

class ResultScreen extends HookWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showLibrary = useProvider(getLibraryProvider);
    final _size = MediaQuery.of(context).size;
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
          data: (libs) => libs.isEmpty
              ? Center(
                  child: Text('周辺の図書館にはありませんでした。'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: libs.map((lib) {
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
            ],
          ),
          error: (err, stack) => Center(
            child: Text('エラーが発生しました。時間をおいて再度お試しください。'),
          ),
        ),
      ),
    );
  }
}
