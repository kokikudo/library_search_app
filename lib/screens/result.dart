//Library
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:expandable/expandable.dart';
// freezed models
// other file
import '../utils/constraints.dart';
import '../widgets/scan_button.dart';
import '../widgets/search_bar.dart';
import '../utils/empty_space.dart';
import '../widgets/empty_show_book_widget.dart';
import '../widgets/show_book_widget.dart';
import '../widgets/library_card.dart';

// 伸縮するWidgetに入れる情報のクラス。本番はFreezedクラスで再定義
class Library {
  Library(this.isExpanded, this.name, this.bookStatus, this.size,
      this.rangeFromHere, this.address, this.post);

  bool isExpanded;
  String name;
  String bookStatus;
  String size;
  String rangeFromHere;
  String address;
  String post;
}

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _canGet = false;
  String _filter = '';

  List<Library> _libList = [
    Library(
        false,
        '相模原市立図書館',
        '貸出可',
        'Large',
        '10',
        '相模原市中央区淵野辺4-48-2',
        '252-0546'),
    Library(
        false,
        '相模原市立図書館',
        '貸出可',
        'Large',
        '10',
        '相模原市中央区淵野辺4-48-2',
        '252-0546'),
    Library(
        false,
        '相模原市立図書館',
        '貸出可',
        'Large',
        '10',
        '相模原市中央区淵野辺4-48-2',
        '252-0546'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text('検索結果'),
      ),
      body: SafeArea(
        child: Column(
          children: [

            /// カテゴリのWidgets。
            Wrap(spacing: 10, children: [
              ChoiceChip(
                label: Text('貸出可'),
                selected: _canGet,
                onSelected: (_) =>
                    setState(() {
                      _canGet = !_canGet;
                    }),
              ),
              ChoiceChip(
                label: Text('~5km'),
                selected: _filter == "~5km",
                onSelected: (_) =>
                    setState(() {
                      if (_filter == "~5km") {
                        _filter = '';
                      } else {
                        _filter = "~5km";
                      }
                    }),
              ),
              ChoiceChip(
                label: Text('~10km'),
                selected: _filter == "~10km",
                onSelected: (_) =>
                    setState(() {
                      if (_filter == "~10km") {
                        _filter = '';
                      } else {
                        _filter = "~10km";
                      }
                    }),
              ),
            ]),

            // 図書館のリスト
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: _libList.map((lib) {
                  return LibraryCard(lib: lib);
                }).toList(),
              ),
            ),
            //LibraryCard()
          ],
        ),
      ),
    );
  }
}


