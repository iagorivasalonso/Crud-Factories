
import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart';
import 'package:crud_factories/Backend/Feature/Factory/exportFactories.dart';
import 'package:crud_factories/Backend/Feature/Factory/importFactories.dart';
import 'package:crud_factories/Objects/Factory.dart';

class CsvFactorydatasource implements IFactoryDataSource {

  final String path;

  CsvFactorydatasource(this.path);

  @override
  Future<List<Factory>> load() async{

    return await csvImportFactories(
      assetPath: this.path,
    );
  }

  @override
  Future<void> delete(String id) async {
        final factories = await load();

        final update = factories.where((f) => f.id != id).toList();

        await csvExportatorFactories(
            update,
            path: this.path
        );
  }

  @override
  Future<void> insert(Factory factory) async {
    final factories = await load();

    final update = [
          ...factories.where((f) => f.id != factory.id),
          factory,
         ];

    await csvExportatorFactories(
    update,
    path: this.path
    );
  }



  @override
  Future<void> upload(Factory factory) async {

    final factories = await load();

    final index = factories.indexWhere((f) => f.id == factory.id);

    if (index == -1) {
      throw Exception('empres con id ${factory.id} no encontrada');
    }

    factories[index] = factory;
  }

}