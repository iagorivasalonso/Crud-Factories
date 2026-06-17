

import 'package:crud_factories/Objects/Factory.dart';

abstract class IFactoryDataSource {

   Future<List<Factory>> load();

   Future<void> insert(Factory factory);

   Future<void> delete(String id);

   Future<void> upload(Factory factory);

}