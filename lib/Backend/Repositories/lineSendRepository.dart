
import 'package:crud_factories/Backend/Feature/LineSend/ILineSendDataSource.dart';
import 'package:crud_factories/Objects/LineSend.dart';

class LinesendRepository {

   final ILineSendDatasource datasource;

   LinesendRepository(this.datasource);

   Future<void> insert(List<LineSend> lines){

      return datasource.insert(lines);
   }

   Future<void> delete(List<LineSend> lines){

     return datasource.delete(lines);
   }

   Future<List<LineSend>> load() {

     return datasource.load();
   }

   Future<bool> upload(List<LineSend> lines){

     return datasource.upload(lines);
   }
}