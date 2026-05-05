import 'package:crud_factories/Alertdialogs/confirm.dart' show confirm;
import 'package:crud_factories/Alertdialogs/createSector.dart';
import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Alertdialogs/warning.dart' show warning;
import 'package:crud_factories/Backend/CSV/exportSectors.dart' show csvExportatorSectors;
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart' show BaseDateSelected;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/SQL/createSector.dart' show sqlCreateSector;
import 'package:crud_factories/Backend/SQL/deleteSector.dart' show sqlDeleteSector;
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/cupertino.dart' show BuildContext;
import 'package:flutter/foundation.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:universal_html/html.dart' show File;

enum CreateResult {
  success,
  alreadyExists,
  invalidData,
}

enum EditResult   {
  success,
  alreadyExists,
  notFound,
  invalidData
}

enum DeleteResult {
  success,
  notFound,
  hasDependencies
}

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

  bool exist(String name, {String? exclude}) {
    final nameLower = name.toLowerCase();

    return _sectors.any((s) {
      final sectorName = s.name.toLowerCase();

      if (exclude != null && sectorName == exclude.toLowerCase()) {
        return false;
      }

      return sectorName == nameLower;
    });
  }

  void clear() {
    _sectors.clear();
    notifyListeners();
  }

  Future<CreateResult> create(Sector sector) async {

    final name= sector.name?.trim();

    if (name == null || sector.name.isEmpty) {
      return CreateResult.invalidData;
    }

    final exits = exist(sector.name);

    if (exits) {
      return CreateResult.alreadyExists;
    }

    final idNew = sectors.isNotEmpty
        ? createId(sectors.last.id)
        : "1";

    final newSector = Sector(
        id: idNew,
        name: sector.name
    );

    _sectors.add(newSector);
    notifyListeners();
    if (BaseDateSelected.isNotEmpty) {
      await sqlCreateSector(newSector);
    } else {
      await csvExportatorSectors(sectors);
    }

    return CreateResult.success;
  }

  Future<EditResult> edit(Sector update) async {

    if(update.name == null || update.name!.trim().isEmpty){
       return EditResult.invalidData;
    }

    final name = update.name!.trim();

    final index = _sectors.indexWhere((s) => s.id == update.id);
    if (index == -1) {
      return EditResult.notFound;
    }

    if (exist(name, exclude: update.name)) {
      return EditResult.alreadyExists;
    }


    final oldSector = _sectors[index];

    final newSector = Sector(
      id: update.id,
      name: name,
    );

    _sectors[index] = newSector;

    notifyListeners();

    if (BaseDateSelected.isNotEmpty) {
      await sqlCreateSector(newSector);
    } else {
      await csvExportatorSectors(_sectors);
    }

    return EditResult.success;
  }

  Future<DeleteResult> delete(
      int index,
      FactoryProvider factoryProvider,
      ) async {

     if(_sectors.isEmpty || index >= _sectors.length)
       return DeleteResult.notFound;

     final sector = _sectors[index];

     final hasFactories = factoryProvider.factories.any(
           (f) => f.sector == sector.id,
     );

     if (hasFactories) {
       return DeleteResult.hasDependencies;
     }

     final removed = _sectors.removeAt(index);
     try {
       //  persistencia
       if (BaseDateSelected.isNotEmpty) {
         await sqlDeleteSector(sector.id);
       } else {
         await csvExportatorSectors(_sectors);
       }
       notifyListeners();

     } catch (e) {
        _sectors.insert(index,removed);
        notifyListeners();
       return DeleteResult.notFound;
     }
     return DeleteResult.success;
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

        for (final s in imported) {
          if (!exist(s.name)) {
            _sectors.add(s);
          }
        } //✔ estado del provider

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