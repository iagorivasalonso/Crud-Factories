
import 'package:crud_factories/Objects/Conection.dart' show Conection;

abstract class IConnectionService {

  Future<bool> create(Conection c);

  Future<bool> update(Conection old, Conection update );

  Future<bool> delete(Conection c);
}