import 'dart:html' as html;
import 'dart:convert';

Future<bool> exportCsv(String csv, {String? file}) async {
  try {
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", file ?? "export.csv")
      ..click();

    html.Url.revokeObjectUrl(url);
    return true;
  } catch (_) {
    return false;
  }
}
