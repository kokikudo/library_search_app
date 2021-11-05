// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_search_app/models/freezed_models/show_library.dart';

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

//final showLibraryFilerProvider = StateProvider((_) => ShowLibraryFilter.all);

final showLibraryFilerProvider = StateNotifierProvider<ShowLibraryFilterNotifier, ShowLibraryFilter>((
    _) => ShowLibraryFilterNotifier());

class ShowLibraryFilterNotifier extends StateNotifier<ShowLibraryFilter> {
  ShowLibraryFilterNotifier() : super(ShowLibraryFilter.all);

  void changeState(ShowLibraryFilter newCategory) => state = newCategory;
}

///フィルタ
// final filteredProvider = Provider<List<ShowLibrary>>((ref) {
//   final libs = ref.read(getLibraryProvider);
//   final filter = ref.watch(showLibraryFilerProvider);
//
//   /// フィルタの種類によって返すリストを変える
//   switch (filter) {
//     case ShowLibraryFilter.rentableAnd10distance:
//     case ShowLibraryFilter.rentableAnd5distance:
//     case ShowLibraryFilter.only10distance:
//     case ShowLibraryFilter.only5distance:
//     case ShowLibraryFilter.onlyRentable:
//     case ShowLibraryFilter.all:
//   }
// });

class ResultScreen extends HookWidget {
  //bool _canGet = false; カテゴリーの選択状態を表すbool値
  // final String _filter = '';

  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showLibrary = useProvider(getLibraryProvider);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('検索結果'),
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
          loading: () => Center(
            child: SizedBox(
              width: _size.width / 4,
              height: _size.height / 4,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpinKitPouringHourGlassRefined(
                      color: Theme.of(context).iconTheme.color!),
                ],
              ),
            ),
          ),
          error: (err, stack) => Text('Error $err'),
        ),
      ),
    );
  }
}

/// カテゴリのWidgets。
// Wrap(spacing: 10, children: [
//   ChoiceChip(
//     label: Text('貸出可'),
//     selected: false,
//     // onSelected: (_) =>
//     //     setState(() {
//     //       _canGet = !_canGet;
//     //     }),
//   ),
//   ChoiceChip(
//     label: Text('~5km'),
//     selected: _filter == "~5km",
//     // onSelected: (_) =>
//     //     setState(() {
//     //       if (_filter == "~5km") {
//     //         _filter = '';
//     //       } else {
//     //         _filter = "~5km";
//     //       }
//     //     }),
//   ),
//   ChoiceChip(
//     label: Text('~10km'),
//     selected: _filter == "~10km",
//     // onSelected: (_) =>
//     //     setState(() {
//     //       if (_filter == "~10km") {
//     //         _filter = '';
//     //       } else {
//     //         _filter = "~10km";
//     //       }
//     //     }),
//   ),
// ]),
