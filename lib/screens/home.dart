// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
// other file
import '../main.dart';
import '../widgets/scan_button.dart';
import '../widgets/search_bar.dart';
import '../utils/empty_space.dart';
import '../widgets/empty_show_book_widget.dart';
import '../widgets/show_book_widget.dart';


class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookStatus = useProvider(showBookProvider);
    return Scaffold(
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              addVerticalEmptySpace(10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 60,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TitleSearchBar(),
                    ),
                    addHorizonEmptySpace(15),
                    ScanButton(),
                  ],
                ),
              ),
              Expanded(
                child: _bookStatus == null
                    ? EmptyShowBookWidget()
                    : ShowBookWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
