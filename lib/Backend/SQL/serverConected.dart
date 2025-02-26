import 'dart:io';
import 'package:crud_factories/Backend/data.dart';

serverconnect() async {

  var executable ='';

  if (Platform.isWindows) {

    executable = routesManage[7].route;

  }

  final arguments = <String>[];
  final process = await Process.start(
      executable, arguments, runInShell: true);

}