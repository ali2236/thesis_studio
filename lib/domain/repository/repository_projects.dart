import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/repository/data_repository.dart';
import 'package:thesis_studio/domain/model/model_project.dart';

class ProjectsRepository extends DataRepository<Project, UUID, void>{
  const ProjectsRepository(super.dataSource);
}