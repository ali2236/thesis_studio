import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';
import 'package:thesis_studio/domain/domain_layer.dart';
import 'package:thesis_studio/domain/repository/repository_cli_tools.dart';
import 'package:thesis_studio/injection.dart';

class ThesisEditor {
  final Project project;
  final BehaviorSubject<String?> _openFile = BehaviorSubject();
  final BehaviorSubject<int> _outputFile = BehaviorSubject();

  ThesisEditor(this.project);

  Stream<String?> watchOpenFile() => _openFile.stream;
  void openFile(String path){
    _openFile.add(p.canonicalize(path));
  }

  Future<void> save(String contents) async{
    assert(_openFile.value != null);
    File(_openFile.value!).writeAsString(contents);
    await generatePDF();
    _outputFile.add(DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> generatePDF() async {
    if (_openFile.valueOrNull != null) {
      final file = _openFile.value!;
      final filenameWOE = p.basenameWithoutExtension(file);
      final tool = await locator.get<CliToolsRepository>().get('XeLaTex').first;
      final parts = tool.command.split(' ');
      final result = await Process.run(
        parts.first,
        parts.skip(1).map((c) => c.replaceAll('%', filenameWOE)).toList(),
        workingDirectory: p.dirname(file)
      );
      log(result.exitCode.toString());
    }
  }

  Stream<int> watchOutput() => _outputFile.stream;
}
