
import 'package:crud_factories/Objects/LineSend.dart';

abstract class ILineSendDatasource {

    Future<List<LineSend>> load();

    Future<void> insert(List<LineSend>lines);

    Future<void> delete(List<LineSend>lines);

    Future<void> upload(List<LineSend>lines);
}