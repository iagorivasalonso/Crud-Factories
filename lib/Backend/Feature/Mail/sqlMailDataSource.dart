
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart' show IMailDataSource;
import 'package:crud_factories/Objects/Mail.dart';

class SqlMailDataSource implements IMailDataSource {

  final Iexecutequery executeQuery;
  final String userId;

  SqlMailDataSource({
    required this.executeQuery, required this.userId
  });

  @override
  Future<void> delete(String id) async{

    await executeQuery.execute(
       'DELETE FROM mails WHERE id= ?  AND user_id = ?',
        [id, userId]
    );
  }

  @override
  Future<List<Mail>> load() async {

     final result = await executeQuery.query(
        'SELECT id, mail, host, port, secure, password FROM mails WHERE user_Id = ?',
         [userId]
     );
     
     return result.map((row) => Mail(
       id: row['id']?.toString() ?? '',
       mail: row['mail']?.toString() ?? '',
       host: row['host']?.toString() ?? '',
       port: row['port']?.toString() ?? '',
       secure: row['secure'] == true || row['secure'] == 1,
       password: row['password']?.toString() ?? '',
     )).toList();
  }

  @override
  Future<List<Mail>> loadSystemMails() async {  // van todos los mails de la bd que sean admin sin id

    final result = await executeQuery.query(
        'SELECT id, mail, host, port, secure, password FROM mails ORDER BY id',
    );

    return result.map((row) => Mail(
      id: row['id']?.toString() ?? '',
      mail: row['mail']?.toString() ?? '',
      host: row['host']?.toString() ?? '',
      port: row['port']?.toString() ?? '',
      secure: row['secure'] == true || row['secure'] == 1,
      password: row['password']?.toString() ?? '',
    )).toList();
  }

  @override
  Future<void> insert(Mail m) async {

    await executeQuery.execute(
       'INSERT INTO mails VALUES (?,?,?,?,?,?,?)',
       [m.id,m.mail,m.host,m.port,m.secure,m.password,userId]
    );
  }

  @override
  Future<void> upload(Mail m) async {

    await executeQuery.execute(
          ' UPDATE mails SET mail = ?, host = ?, port = ?, secure = ?,password = ? WHERE id = ?  AND user_id = ?',
           [m.mail, m.host, m.port, m.secure, m.password, m.id,userId],
    );
  }

  @override
  Future<void> save(List<Mail> mails) async {

    for (final mail in mails) {

      await executeQuery.execute(
          'INSERT INTO mails VALUES (?,?,?,?,?,?,?)',
          [mail.id, mail.mail, mail.host, mail.port, mail.secure, mail.password,userId]
      );

    }
  }

}
