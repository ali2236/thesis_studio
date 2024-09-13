import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:thesis_studio/domain/model/model_project.dart';

class ProjectListTile extends StatelessWidget {
  final Project project;

  const ProjectListTile({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(project.name),
            ],
          ),
          Text(p.prettyUri(project.path), textDirection: TextDirection.ltr,),
        ],
      ),
    );
  }
}
