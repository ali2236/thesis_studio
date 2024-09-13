import 'package:file_picker/file_picker.dart';

class FilePickerUtil {
  static Future<String?> pickFolder() async {
    return await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Open Project',
      lockParentWindow: true,
    );
  }
}