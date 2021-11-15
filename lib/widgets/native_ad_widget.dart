// package
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class NativeAdWidget extends StatelessWidget {
  const NativeAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NativeAd(
      buildLayout: mediumAdTemplateLayoutBuilder,
      height: 320,
      loading: const CircularProgressIndicator(),
      error: const Text('広告のロードに失敗しました。'),
      icon: AdImageView(size: 40),
      builder: (context, child) {
        return Material(
          elevation: 8,
          child: child,
        );
      },
      headline: AdTextView(
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        maxLines: 1,
      ),
      body: AdTextView(
          style: const TextStyle(color: Colors.black), maxLines: 1),
      media: AdMediaView(
        height: 170,
        width: MATCH_PARENT,
      ),
      attribution: AdTextView(
        width: WRAP_CONTENT,
        text: 'Ad',
        decoration: AdDecoration(
          border: const BorderSide(color: Colors.green, width: 2),
          borderRadius: AdBorderRadius.all(16.0),
        ),
        style: const TextStyle(color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      ),
      button: AdButtonView(
        elevation: 18,
        decoration: AdDecoration(backgroundColor: Colors.blue),
        height: MATCH_PARENT,
        textStyle: const TextStyle(color: Colors.white),
      ),
      ratingBar: AdRatingBarView(starsColor: Colors.white),
    );
  }
}
