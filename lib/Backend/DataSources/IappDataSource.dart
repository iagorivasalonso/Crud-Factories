
import 'dart:typed_data';

import 'RoutesBundle.dart';

abstract class AppDataSource {

  Future<RoutesBundle> loadRoutes();

  Future<RoutesBundle> loadRoutesFromBytes(
      Uint8List bytes,
      );
}