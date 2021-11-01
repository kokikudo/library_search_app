//import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
class ScanButton extends StatelessWidget {
  const ScanButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicTheme.of(context)!.current!.buttonStyle!.copyWith(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      onPressed: () {},
      child: Icon(
        Icons.view_week,
        color: NeumorphicTheme.of(context)!.current!.iconTheme.color,
      ),
    );
  }
}
