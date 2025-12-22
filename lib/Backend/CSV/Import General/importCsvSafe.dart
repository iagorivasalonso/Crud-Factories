import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:fluent_ui/fluent_ui.dart' show BuildContext;
import 'importFiles.dart';

Future<bool> importCsvSafe(
    BuildContext context,
    PlatformFile file,
    ) async {
  try {
    await importFiles(context, file);
    return true;
  } catch (e) {
    return false;
  }
}