
import 'dart:io';


Future<bool> exportCsv(String csv, {String? file}) async {
print(csv);
  try {
    if (file == null || file.isEmpty)
      return false;


    final f = File(file);

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
