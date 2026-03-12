import 'dart:io';

import 'package:crud_factories/Backend/Global/list.dart';


class ServerService {

  static Future<bool> _isServerRunning(int port) async {

      try {

           final socket = await Socket.connect('127.0.0.1', port,
             timeout: const Duration(seconds: 1));

           socket.destroy();

          return true;
      } catch (_) {
         return false;
      }
  }

  static Future<bool> startServer() async {

    if(await _isServerRunning(8080)) {
       return false;
    }

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