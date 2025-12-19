
import 'package:universal_html/html.dart' as html;

Future<bool> csvExportweb(String csv, {String fileName = 'routes.csv'}) async {

  try {
      final bytes = csv.codeUnits;
      final blob = html.Blob([bytes],'text/csv');
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
            ..setAttribute('download', fileName)
            ..click();

      html.Url.revokeObjectUrl(url);
    return true;
  } catch (e) {
    print('Error al exportar CSV web: $e');
    return false; // Retorna false si hubo error
  }
}
