import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:thesis_studio/common/types.dart';
import 'package:thesis_studio/data/datasource/data_source.dart';
import 'package:thesis_studio/data/datasource/data_source_sembast.dart';
import 'package:thesis_studio/domain/model/model_project.dart';
import 'package:thesis_studio/domain/repository/repository_cli_tools.dart';
import 'package:thesis_studio/domain/repository/repository_projects.dart';

final locator = GetIt.instance;

Future<void> initDependencyLocator() async {
  final dir = await getApplicationDocumentsDirectory();
  dir.createSync(recursive: true);
  final dbPath = p.join(dir.path, 'data.db');
  final db = await databaseFactoryIo.openDatabase(dbPath, version: 1);


  locator.registerLazySingleton<DataSource<Project, UUID>>(
    () => SembastDataSource(
      db: db,
      modelName: 'Project',
      fromJson: Project.fromJson,
    ),
  );
  locator.registerLazySingleton(() => ProjectsRepository(locator.get()));
  locator.registerLazySingleton(() => CliToolsRepository());

  // presentation
}
