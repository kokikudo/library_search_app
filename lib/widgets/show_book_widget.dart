//Library
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:library_search_app/models/freezed_models/book.dart';
import 'package:library_search_app/utils/empty_space.dart';
import 'package:url_launcher/url_launcher.dart';

// other file
import '../screens/home.dart';
import '../screens/result.dart';
import '../utils/constraints.dart';
import '../main.dart';
import 'library_card.dart';
import 'button_in_show_book_widget.dart';

class ShowBookWidget extends HookWidget {
  const ShowBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showBook = useProvider(showBookProvider);
    final _size = MediaQuery.of(context).size;
    return Neumorphic(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(30),
            //   child: Image.network(
            //     _showBook.largeImageUrl,
            //     height: _size.height / 3,
            //     width: _size.width / 3,
            //     fit: BoxFit.scaleDown,
            //   ),
            // ),

            Container(
              width: _size.width / 3,
              height: _size.height / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(_showBook.largeImageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonInShowBookWidget(iconData: Icons.library_books, label: '詳細'),
                ButtonInShowBookWidget(iconData: Icons.travel_explore, label: '検索'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

