

import 'dart:io';

Future<bool> csvExport(String csv, {required File file,}) async {

  try {
    if (!await file.exists()) {
      print('CSV IO error: el archivo no existe');
      return false;
    }


    await file.writeAsString(csv);
    return true;
  } catch (e) {
    print('CSV IO error: $e');
    return false;
  }

  }



