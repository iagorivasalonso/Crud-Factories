
import 'package:mysql1/src/single_connection.dart';


class actionsBD {

  static Future<bool> createDB(String nameBD, conn) async {

    try {

      await conn.query('CREATE DATABASE $nameBD');
      await conn.query('USE `$nameBD`');

      return true;

    }catch(_){
      return false;
    }

  }

  static Future<bool> createTables(MySqlConnection conn) async {


    try {
      await conn.query('CREATE TABLE IF NOT EXISTS sectors '
          '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
          ' sector varchar(50) NOT NULL)'
      );

      await conn.query('CREATE TABLE IF NOT EXISTS factories '
          '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
          ' name varchar(255) NOT NULL, '
          ' highDate varchar(12),'
          ' sector int(11),'
          ' telephone1 varchar(9),'
          ' telephone2 varchar(9),'
          ' mail varchar(50),'
          ' web varchar(100),'
          ' address varchar(255), '
          ' number varchar(4),'
          ' apartment varchar(10),'
          ' city varchar(10), '
          ' province varchar(10), '
          ' postcode varchar(5), '
          ' FOREIGN KEY fk_sectors(sector) REFERENCES sectors(id))'
      );

      await conn.query('CREATE TABLE IF NOT EXISTS employees '
          '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
          ' name varchar(50) NOT NULL,'
          ' idFactory int(11) NOT NULL,'
          ' FOREIGN KEY fk_employees(idFactory) REFERENCES factories(id)'
          ' ON DELETE CASCADE)'
      );

      await conn.query('CREATE TABLE IF NOT EXISTS lineSends '
          '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
          ' date varchar(12) NOT NULL, '
          ' factory varchar(255) NOT NULL,'
          ' observations varchar(100),'
          ' state varchar(20))'
      );

      await conn.query('CREATE TABLE IF NOT EXISTS mails'
         '(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,'
          'mail VARCHAR(100) NOT NULL,'
          'host VARCHAR(100) NOT NULL,'
          'port INT NOT NULL,'
          'secure BOOLEAN NOT NULL,'
          'password VARCHAR(255) NOT NULL)'
      );
      return true;
    }catch(e){
      print(e);
      return false;
    }


  }

  static Future<bool> deleteDB(String nameBD, MySqlConnection conn) async {

    try {

      await conn.query('DROP DATABASE $nameBD');
      return true;
    }catch(_){
      return false;
    }


  }

  static Future<bool> editDB(String nameBD, String nameBDnew, MySqlConnection conn) async {


    try {

      await conn.query(
        'USE `$nameBD`',
      );

      var results =
      await conn.query(
          'SHOW TABLES'
      );

      await conn.query(
          'CREATE DATABASE $nameBDnew'
      );

            
      for (final row in results) {

            final nameTable = row[0].toString();

            await conn.query(
                'RENAME TABLE '
                    '$nameBD.$nameTable '
                    'TO '
                    '$nameBDnew.$nameTable');
      }

      await conn.query('DROP DATABASE $nameBD');
      return true;
    }catch(e){
      print(e);
      return true;
    } finally {
      await conn.close();
    }
  }
}

