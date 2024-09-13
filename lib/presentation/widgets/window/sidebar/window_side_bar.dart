import 'package:flutter/material.dart';
import 'package:thesis_studio/presentation/widgets/window/sidebar/side_bar_controller.dart';

class WindowSideBar extends StatelessWidget {
  final List<Widget> children;

  const WindowSideBar({super.key, this.children = const []});

  @override
  Widget build(BuildContext context) {
    final controller = SideBarController();
    return SideBarControllerProvider(
      data: controller,
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: SizedBox(
          child: Column(children: children),
        ),
      ),
    );
  }
}
