import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

Future<void> downloadZip(Uint8List bytes, String name) async {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", name)
    ..click();

  html.Url.revokeObjectUrl(url);
}