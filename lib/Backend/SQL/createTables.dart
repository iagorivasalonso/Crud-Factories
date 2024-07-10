 import 'package:crud_factories/Backend/data.dart';

Future<void> createSql() async {

  await conn.query('CREATE TABLE IF NOT EXISTS factories '
      '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
      ' name varchar(255) NOT NULL, '
      ' highDate varchar(12) NOT NULL,'
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
      ' empleoyes varchar(255))'
  );

  await conn.query('CREATE TABLE IF NOT EXISTS lineSends '
      '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
      ' date varchar(12) NOT NULL, '
      ' factory varchar(255) NOT NULL,'
      ' observations varchar(100) NOT NULL,'
      ' state varchar(20) NOT NULL)'
  );

  await conn.query('CREATE TABLE IF NOT EXISTS mails '
      '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
      ' company varchar(20) NOT NULL, '
      ' email varchar(50) NOT NULL,'
      ' password varchar(100) NOT NULL)'
  );


 }