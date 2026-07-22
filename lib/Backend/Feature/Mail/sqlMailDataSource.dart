
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart' show IMailDataSource;
import 'package:crud_factories/Objects/Mail.dart';

class SqlMailDataSource implements IMailDataSource {

  final Iexecutequery executeQuery;

  SqlMailDataSource({
    required this.executeQuery
  });

  @override
  Future<void> delete(String id) async{

    await executeQuery.execute(
       'DELETE FROM mails WHERE id=?',
        [id]
    );
  }

  @override
  Future<List<Mail>> load() async {

     final result = await executeQuery.query(
        'SELECT id, mail, host, port, secure, password FROM mails'
     );
     
     return result.map((row) => Mail(
         id: row['id'].toString(), 
         mail: row['mail'],
         host: row['host'],
         port: row['port'],
         secure: row['secure'],
         password: row['password'],
     )).toList();
  }

  @override
  Future<void> insert(Mail m) async {
print("entro en sql");
    await executeQuery.execute(
       'INSERT INTO mails VALUES (?,?,?,?,?,?)',
       [m.id,m.mail,m.host,m.port,m.secure,m.password]
    );
  }

  @override
  Future<void> upload(Mail m) async {

    await executeQuery.execute(
      'UPDATE mails SET mail, host, port, secure, password WHERE id=?',
        [m.id,m.mail,m.host,m.port,m.secure,m.password]
    );
  }

}