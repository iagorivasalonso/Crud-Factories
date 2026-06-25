
import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Backend/Feature/LineSend/exportLineSend.dart';
import 'package:crud_factories/Backend/Feature/LineSend/importLineSend.dart' show csvImportLineSend;
import 'package:crud_factories/Objects/LineSend.dart';

class CsvLineSendDatasource implements ILineSendDatasource {

  final String path;

  CsvLineSendDatasource(this.path);

  @override
  Future<List<LineSend>> load() async{

    return await csvImportLineSend(
      assetPath: this.path,
    );
  }

  @override
  Future<void> delete(List<LineSend> lines) async {
        final lineSends = await load();

        final idsToDelete = lines.map((l) => l.id).toSet();

        final updated= lineSends.where(
            (l) => !idsToDelete.contains(l.id)
        ).toList();

        await csvExportatorLineSend(
          updated,
          path: this.path,
        );

  }

  @override
  Future<void> insert(List<LineSend> lines) async {
          final lineSends = await load();

          final updated = [
            ...lineSends,
            ...lines,
          ];

          await csvExportatorLineSend(
            updated,
            path: this.path,
          );
  }

  @override
  Future<void> upload(List<LineSend> lines) async {
        final lineSends = await load();

        final idsToUpdate = lines.map((l) => l.id).toSet();

        final update= [
           ...lineSends.where((l) => !idsToUpdate.contains(l.id)),
           ...lines
           ];

        await csvExportatorLineSend(
              update,
              path: this.path,
        );
  }


}