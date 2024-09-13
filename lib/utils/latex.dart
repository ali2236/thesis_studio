import 'dart:io' as io;

class LaTexUtil {
  // xelatex.exe -synctex=1 -interaction=nonstopmode -shell-escape %.tex
  Future<void> xelatex(String directory) async {
    final process = await io.Process.start(
      'xelatex.exe',
      ['-synctex=1', '-interaction=nonstopmode', '-shell-escape', '%.tex'],
      workingDirectory: directory,
    );
  }
}
