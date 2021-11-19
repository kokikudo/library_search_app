// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// other file
import '../widgets/library_card.dart';
import '../widgets/native_ad_widget.dart';
import '../utils/empty_space.dart';

class ResultScreen extends HookWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showLibrary = useProvider(getLibraryProvider);

    return Scaffold(
      appBar: NeumorphicAppBar(
        title: _showLibrary.when(
          data: (_) => const Text('検索結果'),
          loading: () => const Text(''),
          error: (_, stack) => const Text('検索結果'),
        ),
      ),
      body: SafeArea(
        child: _showLibrary.when(
          data: (libs) => libs.isEmpty
              ? const Center(child: Text('周辺の図書館にはありませんでした。'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
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
              const Text('少し時間がかかる場合がございます。'),
              addVerticalEmptySpace(20),
              ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 320,
                    maxWidth: 400,
                  ),
                  child: const NativeAdWidget()),
            ],
          ),
          error: (err, stack) => const Center(
            child: Text('エラーが発生しました。時間をおいて再度お試しください。'),
          ),
        ),
      ),
    );
  }
}
