import 'package:thesis_studio/data/data_layer.dart';
import 'package:thesis_studio/data/repository/repository.dart';

class CliToolsRepository extends Repository<CliTool, String, void>{

  final tools = [
    const CliTool(name: 'XeLaTex', command: 'xelatex.exe -synctex=1 -interaction=nonstopmode -shell-escape %.tex'),
  ];

  @override
  Future<void> add(CliTool model) async{
    tools.add(model);
  }

  @override
  Stream<CliTool> get(String id) async*{
    yield tools.firstWhere((tool) => tool.name == id);
  }

  @override
  Stream<List<CliTool>> getAll(void filter) async*{
    yield tools;
  }

  @override
  Future<void> update(String id, CliTool? model) {
    throw UnimplementedError();
  }

}