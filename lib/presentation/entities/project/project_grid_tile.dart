import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:thesis_studio/domain/model/model_project.dart';
import 'package:thesis_studio/domain/repository/repository_projects.dart';
import 'package:thesis_studio/injection.dart';
import 'package:thesis_studio/presentation/navigation/context_extention.dart';
import 'package:thesis_studio/presentation/pages/project/page_project.dart';
import 'package:thesis_studio/presentation/widgets/gestures/desktop_gesture_detector.dart';

class ProjectGridTile extends StatefulWidget {
  final Project project;

  const ProjectGridTile({
    super.key,
    required this.project,
  });

  @override
  State<ProjectGridTile> createState() => _ProjectGridTileState();
}

class _ProjectGridTileState extends State<ProjectGridTile> {
  var hover = false;

  @override
  Widget build(BuildContext context) {
    final rad = BorderRadius.circular(16);
    return DesktopGestureDetector(
      onHover: (h) {
        setState(() {
          hover = h;
        });
      },
      onRightClick: (event) {
        showMenu<Function()>(
          context: context,
          position: RelativeRect.fromSize(
              event.position & Size(48.0, 48.0),
              (Overlay.of(context).context.findRenderObject() as RenderBox)
                  .size),
          items: [
            PopupMenuItem(
              child: const Text('Delete'),
              value: () {
                locator.get<ProjectsRepository>().update(
                      widget.project.uniqueKey,
                      null,
                    );
              },
            ),
          ],
        ).then((f) {
          if (f != null) {
            f();
          }
        });
      },
      onLeftClick: (_) =>
          context.push((c) => ProjectPage(project: widget.project)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: rad),
        elevation: hover ? 10 : null,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: 256,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  borderRadius: rad,
                ),
                child: const Center(
                  child: Icon(CommunityMaterialIcons.file_document),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.project.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(
              p.prettyUri(widget.project.path),
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 10),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
