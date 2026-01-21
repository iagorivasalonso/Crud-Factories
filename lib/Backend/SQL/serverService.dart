import 'dart:io';

import 'package:crud_factories/Backend/Global/list.dart';
import 'package:flutter/foundation.dart';


class ServerService {

  static Future<bool> startServer() async {

    if (Platform.isWindows) {
      String executable = routesCSV[2].route;
      try {
        await Process.start(executable, [], runInShell: true);
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}