
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';

import 'RoutesBundle.dart';

abstract class AppDataSource {

  Future<RoutesBundle> loadRoutes(BuildContext conntext);

  Future<RoutesBundle> loadRoutesFromBytes(
      Uint8List bytes,
      );
}
