import 'package:flutter/material.dart';

import '../gestures/hover_builder.dart';

class SelectableTextButton extends StatelessWidget {
  final Widget child;
  final bool selected;
  final void Function(Offset position)? onTap;

  const SelectableTextButton({
    super.key,
    required this.child,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(onLeftClick: (details) {
      if (onTap != null) {
        onTap!(details.position);
      }
    }, builder: (context, hover) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: hover || selected ? Theme.of(context).colorScheme.surfaceBright : null,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
            horizontal: 5,
          ),
          child: IconTheme(
            data: IconTheme.of(context).copyWith(size: 18),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: child,
            ),
          ),
        ),
      );
    });
  }
}
