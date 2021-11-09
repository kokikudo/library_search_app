// package
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// freezed
import '../main.dart';
import '../models/freezed_models/show_library.dart';

// repo
import '../repositories/get_show_library.dart';

// other file
import '../utils/constraints.dart';
import '../utils/empty_space.dart';
import '../utils/url_launch.dart';

final isbnProvider =
    StateNotifierProvider<ISBNNotifier, String>((_) => ISBNNotifier());

class ISBNNotifier extends StateNotifier<String> {
  ISBNNotifier() : super('');

  void changeState(newIsbn) => state = newIsbn;
}

final getLibraryProvider =
    FutureProvider.autoDispose<List<ShowLibrary>>((ref) async {
  final _cancelToken = CancelToken();
  ref.onDispose(() => _cancelToken.cancel());
  final _isbn = ref.watch(isbnProvider);
  final _repo = GetShowLibraryRepo(ref.read, _isbn, _cancelToken);
  final _result = await _repo.getShowLibrary();
  ref.maintainState = true;
  return _result;
});

class LibraryCard extends HookWidget {
  const LibraryCard({
    Key? key,
    required this.lib,
  }) : super(key: key);

  final ShowLibrary lib;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          scrollOnExpand: true,
          scrollOnCollapse: false,
          child: ExpandablePanel(
            theme: ExpandableThemeData(
              tapBodyToCollapse: true,
              tapBodyToExpand: true,
            ),
            collapsed: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '〒${lib.post}\n${lib.address}',
                  textAlign: TextAlign.start,
                  style: textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(5),
                Text(
                  lib.name,
                  style: textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(20),
                LibStatusBar(lib: lib),
                addVerticalEmptySpace(10),
                Icon(Icons.expand_more),
              ],
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '〒${lib.post}\n${lib.address}',
                  textAlign: TextAlign.start,
                  style: textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(5),
                Text(
                  lib.name,
                  style: textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(20),
                LibStatusBar(lib: lib),
                addVerticalEmptySpace(20),
                CardButton(
                  text: 'Google Map',
                  icon: Icon(Icons.map),
                  lib: lib,
                ),
                addVerticalEmptySpace(20),
                lib.bookPageUrl == ''
                    ? Text(
                        '本の予約ページが見つかりませんでした。',
                        textAlign: TextAlign.center,
                        style: textTheme.caption,
                      )
                    : CardButton(
                        text: '予約する',
                        icon: Icon(Icons.launch),
                        lib: lib,
                      ),
                addVerticalEmptySpace(20),
                CardButton(
                  text: '図書館の詳細',
                  icon: Icon(Icons.location_city),
                  lib: lib,
                ),
                addVerticalEmptySpace(20),
              ],
            ),
            builder: (_, collapsed, expanded) {
              return Neumorphic(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.lib,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final ShowLibrary lib;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final latitude = lib.geocode.split(',')[0];
    final longitude = lib.geocode.split(',')[1];
    final urlToGoogleMap =
        'https://www.google.com/maps/search/?api=1&query=$longitude%2C$latitude';
    return NeumorphicButton(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          addHorizonEmptySpace(10),
          Text(
            text,
            style: textTheme.button,
          ),
        ],
      ),
      onPressed: () {
        if (icon.icon == Icons.map) {
          launchURL(urlToGoogleMap);
        } else if (icon.icon == Icons.launch) {
          launchURL(lib.bookPageUrl);
        } else {
          launch(lib.libPageUrl);
        }
      },
    );
  }
}

class LibStatusBar extends StatelessWidget {
  const LibStatusBar({
    Key? key,
    required this.lib,
  }) : super(key: key);

  final ShowLibrary lib;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LibStatusWidget(
            statusName: '貸出状況',
            status: lib.status,
          ),
          VerticalDivider(
            color: kcBrown,
            thickness: 1,
            indent: 5,
            endIndent: 5,
          ),
          LibStatusWidget(
            statusName: 'ここから',
            status: lib.distance.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }
}

class LibStatusWidget extends HookWidget {
  const LibStatusWidget({
    Key? key,
    required this.statusName,
    required this.status,
  }) : super(key: key);

  final String statusName;
  final String status;

  @override
  Widget build(BuildContext context) {
    final _isLightTheme = useProvider(isLightThemeProvider);
    final _normalColor = _isLightTheme ? kcBrown : kcWhite;
    final _accentColor = _isLightTheme ? kcRed : kcPink;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          statusName,
          style: textTheme.caption,
        ),
        statusName == 'ここから'
            ? Text(
                '$status km',
                style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            : Text(
                status,
                style: textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: status == '貸出可' ? _accentColor : _normalColor,
                ),
              )
      ],
    );
  }
}
