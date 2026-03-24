import 'dart:html' as html;
import 'dart:convert';

Future<bool> exportCsv(String csv, {String? file}) async {
  try {
    final filename = file ?? 'export.csv';
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", filename);

    final body = html.document.body;
    if (body == null) throw Exception('No body');

    body.append(anchor);
    anchor.click();
    anchor.remove();

    Future.delayed(const Duration(milliseconds: 100),
            () => html.Url.revokeObjectUrl(url));

    return true;
  } catch (e) {
    print('CSV WEB error: $e');
    return false;
  }
}