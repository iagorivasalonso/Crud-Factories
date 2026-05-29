import 'dart:io';


class Serverservice{

  static Process? _process;

  @override
  static Future<bool> startServer(String executablePath) async {

        if(await _isServerRunning(8080)) {
           return true;
        }

        if(Platform.isWindows)
        {
            try {
              _process = await Process.start(
                   executablePath,
                   [],
               runInShell: true);

               return true;

            } catch(e) {

               print("error Start Server $e");
               return false;
            }
        }

      return false;
  }

  static Future<bool> _isServerRunning(int port) async {

      try {
           final socket = await Socket.connect(
               '127.0.0.1',
               port,
               timeout: const Duration(seconds: 1),
           );

           socket.destroy();

           return true;

      } catch (_) {
         return false;
      }
  }
}