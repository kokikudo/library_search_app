// package
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

final bannerControllerProvider = Provider.autoDispose((ref) {
  final controller = BannerAdController();
  ref.onDispose(() => controller.dispose());

  controller.load();

  return controller;
});

class BannerAdWidget extends HookWidget {
  const BannerAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(bannerControllerProvider);
    return BannerAd(
      controller: controller,
      size: BannerSize.ADAPTIVE,
      builder: (context, child) {
        return Container(
          color: Colors.black,
          child: child,
        );
      },
      loading: const Center(child: CircularProgressIndicator()),
      error: const Text('広告のロードに失敗しました。'),
    );
  }
}
