import 'dart:io';

import 'package:crud_factories/Backend/Global/list.dart';


serverconnect() async {

  var executable ='';

  if (Platform.isWindows) {

    executable = routesCSV[2].route;

  }

  final arguments = <String>[];
  final process = await Process.start(
      executable, arguments, runInShell: true);

}