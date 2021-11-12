// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

// models
import '../models/freezed_models/book.dart';

// other file
import '../main.dart';
import '../widgets/search_bar.dart';
import '../widgets/banner_ad_widget.dart';
import '../utils/empty_space.dart';
import '../widgets/empty_show_book_widget.dart';
import '../widgets/show_book_widget.dart';

final showBookProvider =
    StateNotifierProvider<ShowBookNotifier, Book>((ref) => ShowBookNotifier());

class ShowBookNotifier extends StateNotifier<Book> {
  ShowBookNotifier()
      : super(Book(
            title: '',
            subTitle: '',
            author: '',
            isbn: '',
            salesDate: '',
            publisherName: '',
            itemCaption: '',
            largeImageUrl: ''));

  changeState(newBook) => state = newBook;
}

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showBook = useProvider(showBookProvider);
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
              BannerAdWidget()
            ],
          ),
        ),
      ),
    );
  }
}
