
import 'dart:typed_data';


class AppFile {

  final String name;
  final String? path;
  final Uint8List? bytes;
  final String? assetPath;

  AppFile ({
    required this.name,
    this.path,
    this.bytes,
    this.assetPath,
  });
}