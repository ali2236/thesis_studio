import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/data_layer.dart';
import 'package:uuid/uuid.dart';

import 'model_user.dart';

part 'model_project.g.dart';

@JsonSerializable()
class Project extends Model<UUID>{
  final UUID projectId;
  final User? user;
  final String name;
  final Uri path;
  final DateTime? lastOpen;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Project({
    required this.projectId,
    required this.user,
    required this.name,
    required this.path,
    required this.lastOpen,
    required this.createdAt,
    required this.updatedAt,
  });

  static const fromJson = _$ProjectFromJson;

  factory Project.fromPath(String path) {
    return Project(
      projectId: const Uuid().v4(),
      user: null,
      name: p.basenameWithoutExtension(path).replaceAll(RegExp('-|_'), ' '),
      path: Uri.directory(path),
      lastOpen: null,
      createdAt: DateTime.timestamp(),
      updatedAt: DateTime.timestamp(),
    );
  }

  @override
  UUID get uniqueKey => projectId;

  @override
  JSON toJson() => _$ProjectToJson(this);
}
