import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/LineSend.dart' show LineSend;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';


class LineSendProvider extends ChangeNotifier {

  final List<LineSend> _Lines = [];

  List<LineSend> get LineSends => List.unmodifiable(_Lines);

  void setLineSends(List<LineSend> data) {
    _Lines
      ..clear()
      ..addAll(data);

    notifyListeners();
  }

  void addLineSend(LineSend LineSend) {
    _Lines.add(LineSend);
    notifyListeners();
  }

  void deleteById(String id) {
    _Lines.removeWhere((l) => l.id == id);
    notifyListeners();
  }

  void clear() {
    _Lines.clear();
    notifyListeners();
  }

  Future<void>importLines (BuildContext context, {
    required File file,
    Uint8List? bytes,
    String? content,
    String? assetPath,
  })async {

    try {
      final imported = await csvImportLines(
        file: fLines,
        bytes: bytes,
        content: content,
        assetPath: assetPath,
      );
      _Lines.addAll(imported); // ✔ estado del provider
    } catch (e) {
      final s = S.of(context);

      final msg = e.toString().toLowerCase();

      if (msg.contains("not found") ||
          msg.contains("archivo") ||
          msg.contains("asset")) {
        errorFiles.add("${s.file_not_found} ${s.lines}");
      } else {
        errorFiles.add("${s.file_format_error} ${s.lines}");
      }
    }
    notifyListeners();
  }

}