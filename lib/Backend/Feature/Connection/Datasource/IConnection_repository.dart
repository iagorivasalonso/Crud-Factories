
import 'package:crud_factories/Objects/Conection.dart';

abstract class IConnectionDataSource  {

   Future<List<Conection>> load ();

   Future<void> save (Conection connection);

   Future<void> delete(String id);
 }