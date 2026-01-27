
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<bool> exportCsv(String csv, {required File file,}) async {

  try {
    if (kIsWeb) {

      return true;
    } else {
      if (file == null) return false;

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      await file.writeAsString(csv);
      return true;
    }
  } catch (e) {
    print('CSV IO error: $e');
    return false;
  }

}
