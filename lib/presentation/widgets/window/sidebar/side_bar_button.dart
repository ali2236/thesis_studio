import 'package:flutter/material.dart';
import 'package:thesis_studio/presentation/widgets/gestures/hover_builder.dart';
import 'package:thesis_studio/presentation/widgets/window/sidebar/side_bar_controller.dart';

class SideBarButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback? onTap;

  const SideBarButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: SideBarController.of(context).selected,
        builder: (context, snapshot) {
          final selected = snapshot.data == label;
          return Tooltip(
            message: label,
            child: HoverBuilder(onLeftClick: (pos) {
              if (onTap != null) {
                onTap!();
              } else {
                SideBarController.of(context).select(label);
              }
            }, builder: (context, hover) {
              final colors = Theme.of(context).colorScheme;
              var bgColor = selected
                  ? colors.secondaryContainer
                  : colors.surfaceContainer;
              var iconColor =
                  selected ? colors.onSecondaryContainer : colors.onSurface;
              if (hover) {
                bgColor = Color.lerp(bgColor, Colors.white, 0.15)!;
              }
              return Container(
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconTheme(
                    data: IconTheme.of(context).copyWith(color: iconColor),
                    child: icon,
                  ),
                ),
              );
            }),
          );
        });
  }
}
