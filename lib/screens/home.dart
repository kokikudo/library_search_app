// package
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

// other file
import '../main.dart';
import '../widgets/search_bar.dart';
import '../utils/empty_space.dart';
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

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showBook = useProvider(showBookProvider);
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              addVerticalEmptySpace(10),
              TitleSearchBar(),
              Expanded(
                child: _showBook.title.isEmpty
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
