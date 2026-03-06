
import 'dart:io';


Future<bool> exportCsv(String csv, {String? file}) async {

  try {

    final f = File(file ?? "export.csv");

    if (!await f.exists()) {
      await f.create(recursive: true);
    }

    await f.writeAsString(csv);
    return true;

  } catch (e) {
    print('CSV IO error: $e');
    return false;
  }

}
