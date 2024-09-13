import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:thesis_studio/presentation/widgets/gestures/hover_builder.dart';
import 'package:window_manager/window_manager.dart';

class WindowTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget> actions;

  const WindowTopBar({super.key, this.title, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                dragArea(Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                      child: Icon(CommunityMaterialIcons.file_document_outline,
                          size: 16),
                    ),
                    if (title != null)
                      Text(title!,
                          style: Theme.of(context).textTheme.bodySmall),
                  ],
                )),
                ...actions,
                Expanded(child: dragArea()),
                HoverBuilder(builder: (context, hover) {
                  return GestureDetector(
                    onTap: () => windowManager.minimize(),
                    child: Container(
                      width: 40,
                      color: hover
                          ? Theme.of(context).colorScheme.surfaceBright
                          : null,
                      child:
                          const Center(child: Icon(Icons.minimize, size: 12)),
                    ),
                  );
                }),
                HoverBuilder(builder: (context, hover) {
                  return GestureDetector(
                    onTap: () {
                      windowManager.maximize();
                    },
                    child: Container(
                      width: 40,
                      color: hover
                          ? Theme.of(context).colorScheme.surfaceBright
                          : null,
                      child: const Center(
                          child: Icon(Icons.square_outlined, size: 12)),
                    ),
                  );
                }),
                HoverBuilder(builder: (context, hover) {
                  return GestureDetector(
                    onTap: () => windowManager.close(),
                    child: Container(
                      width: 40,
                      color: hover ? Colors.red : null,
                      child: const Center(child: Icon(Icons.close, size: 16)),
                    ),
                  );
                }),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }

  Widget dragArea([Widget? child]) {
    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      onDoubleTap: () => windowManager.maximize(),
      child: child ?? Container(color: Colors.transparent),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(32);
}
