import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DesktopGestureDetector extends StatelessWidget {
  final Widget child;
  final void Function(bool hover)? onHover;
  final void Function(PointerDownEvent event)? onRightClick;
  final void Function(PointerDownEvent event)? onLeftClick;

  const DesktopGestureDetector({
    super.key,
    required this.child,
    this.onHover,
    this.onRightClick,
    this.onLeftClick,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onHover == null
          ? null
          : (_) {
              onHover!(true);
            },
      onExit: onHover == null
          ? null
          : (_) {
              onHover!(false);
            },
      child: TapRegion(
        onTapInside: (event) {
          if (event.buttons == kSecondaryMouseButton && onRightClick != null) {
            onRightClick!(event);
          } else if (event.buttons == kPrimaryMouseButton &&
              onLeftClick != null) {
            onLeftClick!(event);
          }
        },
        child: child,
      ),
    );
  }
}
