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
    return _sectors.any((s) =>
    s.name.toLowerCase() == name.toLowerCase() &&
        s.name.toLowerCase() != exclude?.toLowerCase());
  }

  void clear() {
    _sectors.clear();
    notifyListeners();
  }

  Future<void> create(BuildContext context) async {

      final sector = await createSector(context);

      if(sector != null)
      {
         final exists = exist(sector.name!);

        if (exists) {
          await confirm(context, S.of(context).sector_already_exists);
          return;
        }

        final idNew = sectors.isNotEmpty
             ? createId(sectors.last.id)
             : "1";

         final newSector = Sector(
             id: idNew,
             name: sector.name
         );

         _sectors.add(newSector);

         if (BaseDateSelected.isNotEmpty) {
           await sqlCreateSector(newSector);
         } else {
           await csvExportatorSectors(sectors);
         }
        notifyListeners();

         await confirm(context, S.of(context).sector_created_successfully);
      }

  }

  Future<void> edit(BuildContext context,  Sector sectorOld) async {

    final result = await createSector(context,sectorOld);

    if (result == null) return;

    final index = _sectors.indexWhere((s) => s.id == sectorOld.id);
    if (index == -1) return;

    if (exist(result.name, exclude: sectorOld.name)) {
      await error(context, S.of(context).sector_already_exists);
      return;
    }
    _sectors[index] = Sector(
        id: sectorOld.id,
        name: result.name
    );

    notifyListeners();

    if (BaseDateSelected.isNotEmpty) {
      await sqlCreateSector(_sectors[index]);
    } else {
      await csvExportatorSectors(_sectors);
    }

    await confirm(context, S.of(context).sector_edited_correctly);

  }

  Future<void> delete(
      BuildContext context,
      int index,
      FactoryProvider factoryProvider,
      ) async {

     if(_sectors.isEmpty || index >= _sectors.length) return;

     final sector = _sectors[index];

     final hasFactories = factoryProvider.factories.any(
           (f) => f.sector == sector.id,
     );

     if (hasFactories) {
       await warning(
         context,
         S.of(context).it_cannot_eliminate_the_sector_with_companies,
       );
       return;
     }

     // 2. confirmación
     final confirmed = await warning(
       context,
       S.of(context).confirm_delete_sector,
     );

     if (confirmed != true) return;

     try {
       // 3. actualizar estado primero (UI instantánea)
       final removed = _sectors.removeAt(index);


       // 4. persistencia
       if (BaseDateSelected.isNotEmpty) {
         await sqlDeleteSector(sector.id);
       } else {
         await csvExportatorSectors(sectors);
       }
       notifyListeners();
       // 5. feedback
       await confirm(
         context,
         S.of(context).the_sector_has_been_successfully_removed,
       );

     } catch (e) {
       await warning(context, S.of(context).sector_delete_error);
     }
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