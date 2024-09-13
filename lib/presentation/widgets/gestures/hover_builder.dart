import 'package:flutter/material.dart';
import 'package:thesis_studio/presentation/widgets/gestures/desktop_gesture_detector.dart';

class HoverBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool hover) builder;
  final void Function(PointerDownEvent event)? onLeftClick;

  const HoverBuilder({
    super.key,
    required this.builder,
    this.onLeftClick,
  });

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  var hovering = false;

  @override
  Widget build(BuildContext context) {
    return DesktopGestureDetector(
      onHover: (h) {
        setState(() {
          hovering = h;
        });
      },
      onLeftClick: widget.onLeftClick,
      child: widget.builder(context, hovering),
    );
  }
}
