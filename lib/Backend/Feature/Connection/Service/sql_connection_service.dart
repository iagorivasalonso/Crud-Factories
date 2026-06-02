
import 'package:archive/archive.dart';
import 'package:crud_factories/Backend/Feature/Connection/Service/IConnectionService.dart' show IConnectionService;
import 'package:crud_factories/Backend/SQL/manageSQl.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:mysql1/mysql1.dart';

class SqlConnectionService implements IConnectionService {

  SqlConnectionService();
  Future<MySqlConnection> _open (Conection c)  async {
    
    final settings = ConnectionSettings(
      host: c.host,
      port: int.parse(c.port),
      user: c.user,
      password: c.password,
    );

    return await MySqlConnection.connect(
      settings,
    );
    
  }
  
  @override
  Future<bool> create(Conection c) async {
    
    MySqlConnection? conn;
    
    try{
       
       conn = await _open(c);
       
       final create = 
             await actionsBD.createDB(
                 c.database,
                 conn
             );
       
       if(!create){
           return false;
       }


       await conn.query(
         'USE `${c.database}`',
       );

       final tables =
       await actionsBD.createTables(
         conn,
       );

       return !tables;


    }catch(_) {
      return false;
    }finally {
      await conn?.close();
    }
  }

  @override
  Future<bool> delete(Conection c) async {

    MySqlConnection? conn;

    try{

      conn = await _open(c);

      return await actionsBD.deleteDB(
          c.database,
          conn
      );

    }finally {
      await conn?.close();
     }
  }

  @override
  Future<bool> update(Conection old, Conection update) async {

    MySqlConnection? conn;

    try{

      conn = await _open(old);

      return await actionsBD.editDB(
          old.database,
          update.database,
          conn
      );

    }finally {
      await conn?.close();
  }

  }
}