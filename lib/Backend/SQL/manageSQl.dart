import 'package:crud_factories/Backend/Global/variables.dart';



Future<bool> createDB(String nameBD, conn) async {

  try {
    await conn.query('CREATE DATABASE $nameBD');
    await conn.query('USE `$nameBD`');
          return true;
  }catch(SQLException){
    return false;
  }
}

Future<bool> createTables() async {

  bool err=false;

  try {
    await executeQuery.query('CREATE TABLE IF NOT EXISTS sectors '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' sector varchar(50) NOT NULL)'
    );

    await executeQuery.query('CREATE TABLE IF NOT EXISTS factories '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' name varchar(255) NOT NULL, '
        ' highDate varchar(12) NOT NULL,'
        ' sector int(11) NOT NULL,'
        ' telephone1 varchar(9) NOT NULL,'
        ' telephone2 varchar(9) NOT NULL,'
        ' mail varchar(50) NOT NULL,'
        ' web varchar(100) NOT NULL,'
        ' address varchar(255) NOT NULL, '
        ' number varchar(4) NOT NULL,'
        ' apartament varchar(10) NOT NULL,'
        ' city varchar(10) NOT NULL, '
        ' province varchar(10) NOT NULL, '
        ' postalcode varchar(5) NOT NULL, '
        ' FOREIGN KEY fk_sectors(sector) REFERENCES sectors(id))'
    );

    await executeQuery.query('CREATE TABLE IF NOT EXISTS empleoyes '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' name varchar(50) NOT NULL,'
        ' idFactory int(11) NOT NULL,'
        ' FOREIGN KEY fk_empleoyes(idFactory) REFERENCES factories(id)'
        ' ON DELETE CASCADE)'
    );

    await executeQuery.query('CREATE TABLE IF NOT EXISTS lineSends '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' date varchar(12) NOT NULL, '
        ' factory varchar(255) NOT NULL,'
        ' observations varchar(100) NOT NULL,'
        ' state varchar(20) NOT NULL)'
    );

    await executeQuery.query('CREATE TABLE IF NOT EXISTS mails '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' company varchar(20) NOT NULL, '
        ' email varchar(50) NOT NULL,'
        ' password varchar(100) NOT NULL)'
    );

  }catch(SQLException){
    err = true;
  }

  return err;
}

Future<bool> deleteDB(String nameBD) async {

  bool err= false;

  try {

    await executeQuery.query('DROP DATABASE $nameBD');

  }catch(SQLException){
        err=true;
  }

  return err;
}

Future<bool> editDB(String nameBD, String nameBDnew) async {

  bool err=false;

  try {
    var results = await executeQuery.query('SHOW TABLES');
    await executeQuery.query('CREATE DATABASE $nameBDnew');
    for (final row in results) {
      final nameTable = row[0].toString();
        await executeQuery.query(
            'RENAME TABLE $nameBD.$nameTable TO $nameBDnew.$nameTable');
      }

      await executeQuery.query('DROP DATABASE $nameBD');

  }catch(e){
    err = true;
  } finally {
    await executeQuery.close();
  }
  return err;
}