// package
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BannerAd(
      size: BannerSize.ADAPTIVE,
      builder: (context, child) {
        return Container(
          color: Colors.black,
          child: child,
        );
      },
      loading: Center(child: CircularProgressIndicator()),
      error: Text('広告のロードに失敗しました。'),
    );
  }
}
