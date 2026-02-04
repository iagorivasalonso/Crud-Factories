
import 'dart:io';


Future<bool> exportCsvIO(String csv, {required File file,}) async {

  try {

    if (!await file.exists()) {
      await file.create(recursive: true);
    }

    await file.writeAsString(csv);
    return true;

  } catch (e) {
    print('CSV IO error: $e');
    return false;
  }

}
