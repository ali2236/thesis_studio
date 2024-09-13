import 'package:flutter/material.dart';
import 'package:thesis_studio/domain/domain_layer.dart';
import 'package:thesis_studio/domain/repository/repository_projects.dart';
import 'package:thesis_studio/injection.dart';
import 'package:thesis_studio/presentation/entities/project/project_grid_tile.dart';
import 'package:thesis_studio/presentation/navigation/route_builder.dart';
import 'package:thesis_studio/presentation/widgets/window/topbar/window_top_bar.dart';
import 'package:thesis_studio/utils/file_picker.dart';

import '../project/page_project.dart';

class ProjectsListPage extends StatelessWidget {
  const ProjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final projectsRepository = locator.get<ProjectsRepository>();
    final all = projectsRepository.getAll(null);
    return Scaffold(
      appBar: const WindowTopBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Text(
                    'Thesis Studio',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      final folder = await FilePickerUtil.pickFolder();
                      if (folder != null) {
                        final project = Project.fromPath(folder);
                        await projectsRepository.add(project);
                        final route = RouteBuilder.route((context) => ProjectPage(project: project));
                        nav.push(route);
                      }
                    },
                    child: const Text('Open'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: all,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final projects = snapshot.requireData;
                  if(projects.isEmpty){
                    return const Center(child: Text('No Projects'));
                  }
                  return GridView.builder(
                    padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                    itemCount: projects.length,
                    itemBuilder: (context, i) {
                      final project = projects[i];
                      return ProjectGridTile(project: project);
                    },
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      childAspectRatio: 180 / 240,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
