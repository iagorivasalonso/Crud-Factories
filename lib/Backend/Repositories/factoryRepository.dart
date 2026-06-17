

import 'package:crud_factories/Backend/Feature/Factory/IFactoryDataSource.dart' show IFactoryDataSource;
import 'package:crud_factories/Objects/Factory.dart';

class FactoryRepository {

  final IFactoryDataSource dataSource;

  FactoryRepository(this.dataSource);

  Future <void> insert(Factory factory) {

    return dataSource.insert(factory);
  }

  Future<void> delete (String id) {

    return dataSource.delete(id);
  }

  Future<List<Factory>> load() {

    return dataSource.load();
  }

  Future<void> upload (Factory factory) async {

    return dataSource.upload(factory);
  }
}