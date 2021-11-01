import 'package:expandable/expandable.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import '../screens/result.dart';
import '../utils/constraints.dart';
import '../utils/empty_space.dart';

/// 展開するとWidgetの両端が切れて表示されてしまう。
///　デザインが一通り終わったら再度対処する。
class LibraryCard extends StatelessWidget {
  const LibraryCard({
    Key? key,
    required this.lib,
  }) : super(key: key);

  final Library lib;

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
                  lib.name,
                  style: textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(20),
                LibStatusWidgetBar(),
                addVerticalEmptySpace(10),
                Icon(Icons.expand_more),
              ],
            ),
            expanded: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  lib.name,
                  style: textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalEmptySpace(20),
                LibStatusWidgetBar(),
                addVerticalEmptySpace(20),
                Text(
                  '〒${lib.post}\n${lib.address}',
                  textAlign: TextAlign.start,
                ),
                addVerticalEmptySpace(20),
                ButtonInLibCard(
                  text: 'Google Map',
                  icon: Icon(Icons.map),
                ),
                addVerticalEmptySpace(20),
                ButtonInLibCard(
                  text: '図書館ホームページ',
                  icon: Icon(Icons.logout),
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

class ButtonInLibCard extends StatelessWidget {
  const ButtonInLibCard({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return NeumorphicButton(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textTheme.button,
          ),
          addHorizonEmptySpace(10),
          icon,
        ],
      ),
      onPressed: () {
        if (icon.icon == Icons.map) {
          ///TODO GoogleMapに飛ぶ
        } else {
          ///TODO 予約サイトに飛ぶ
        }
      },
    );
  }
}

class LibStatusWidgetBar extends StatelessWidget {
  const LibStatusWidgetBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LibStatusWidget(
            textTheme: textTheme,
            statusName: '貸出状況',
            status: '貸出可',
          ),
          VerticalDivider(
            color: kcBrown,
            thickness: 1,
            indent: 5,
            endIndent: 5,
          ),
          LibStatusWidget(
            textTheme: textTheme,
            statusName: '図書館の規模',
            status: '大きい',
          ),
          VerticalDivider(
            color: kcBrown,
            thickness: 1,
            indent: 5,
            endIndent: 5,
          ),
          LibStatusWidget(
            textTheme: textTheme,
            statusName: 'ここから',
            status: '10km',
          ),
        ],
      ),
    );
  }
}

class LibStatusWidget extends StatelessWidget {
  const LibStatusWidget({
    Key? key,
    required this.textTheme,
    required this.statusName,
    required this.status,
  }) : super(key: key);

  final TextTheme textTheme;
  final String statusName;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          statusName,
          style: textTheme.caption,
        ),
        Text(
          status,

          ///TODO 『貸出可』の時のみ文字の色を変更
          style: textTheme.bodyText1!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
