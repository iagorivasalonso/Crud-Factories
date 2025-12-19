import 'package:file_picker/file_picker.dart' show PlatformFile;
import 'package:fluent_ui/fluent_ui.dart' show BuildContext;
import '../../../Alertdialogs/error.dart';
import '../../../generated/l10n.dart';
import 'importFiles.dart';

Future<bool> importCsvSafe(
    BuildContext context,
    PlatformFile file,
    ) async {
  try {
    await importFiles(context, file);
    return true;
  } catch (e) {
    error(context, S.of(context).route_file_cannot_be_read);
    return false;
  }
}