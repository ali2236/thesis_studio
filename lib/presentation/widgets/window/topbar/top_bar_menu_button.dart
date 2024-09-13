import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

import '../../buttons/selectable_text_button.dart';

class TopBarMenuButton extends StatelessWidget {
  final String label;
  final List<ContextMenuItem>? menu;
  final VoidCallback? onTap;

  const TopBarMenuButton({
    super.key,
    required this.label,
    this.menu,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SelectableTextButton(
      child: Text(label),
      onTap: (pos) {
        if (menu != null) {
          showContextMenu(
            context,
            contextMenu: ContextMenu(
              position: pos,
              entries: menu!,
            ),
          );
        } else if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
