import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/cupertino.dart' show BuildContext;
import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:universal_html/html.dart' show File;

class SectorProvider extends ChangeNotifier {

  final List<Sector> _sectors = [];

  List<Sector> get sectors => List.unmodifiable(_sectors);

  void setSectors(List<Sector> data) {
    _sectors
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  void addSector(Sector sector) {
    _sectors.add(sector);
    notifyListeners();
  }

  void delete(String id) {
    _sectors.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void clear() {
    _sectors.clear();
    notifyListeners();
  }
  bool exist(String name, {String? exclude}) {
    return _sectors.any((s) =>
    s.name.toLowerCase() == name.toLowerCase() &&
        s.name.toLowerCase() != exclude?.toLowerCase());
  }

  void updateSector(Sector updated) {
    final index = _sectors.indexWhere((s) => s.id == updated.id);

    if (index != -1) {
      _sectors[index] = updated;
      notifyListeners();
    }
  }

  void removeSector(String id) {
    _sectors.removeWhere((s) => s.id == id);
    notifyListeners();
  }



  Future<void>importSectors(BuildContext context, {
      required File file,
      Uint8List? bytes,
      String? content,
      String? assetPath,
    }) async {
      try {
        final imported = await csvImportSectors(
          file: fSectors,
          bytes: bytes,
          content: content,
          assetPath: assetPath,
        );

        _sectors.addAll(imported); // ✔ estado del provider
      } catch (e) {
        final s = S.of(context);

        final msg = e.toString().toLowerCase();

        if (msg.contains("not found") ||
            msg.contains("archivo") ||
            msg.contains("asset")) {
          errorFiles.add("${s.file_not_found} ${s.routes}");
        } else {
          errorFiles.add("${s.file_format_error} ${s.routes}");
        }
      }

      notifyListeners();
    }

}