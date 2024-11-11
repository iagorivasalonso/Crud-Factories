import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:flutter/material.dart';


Future<String> createDB(BuildContext context, String nameBD, conn) async {

  String err ="";

  try {
    await conn.query('CREATE DATABASE $nameBD');

  }catch(SQLException){
    err = "No se pudo crear la base de datos";
    error(context, err);
  }

  return err;
}

Future<String> createTables(BuildContext context) async {

  String err ="";

  try {
    await conn.query('CREATE TABLE IF NOT EXISTS sectors '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' sector varchar(50) NOT NULL)'
    );

    await conn.query('CREATE TABLE IF NOT EXISTS factories '
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

    await conn.query('CREATE TABLE IF NOT EXISTS empleoyes '
        '(id int NOT NULL AUTO_INCREMENT PRIMARY KEY,'
        ' name varchar(50) NOT NULL,'
        ' idFactory int(11) NOT NULL,'
        ' FOREIGN KEY fk_empleoyes(idFactory) REFERENCES factories(id)'
        ' ON DELETE CASCADE)'
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

  }catch(SQLException){

    String err= "No se pudieron crear las tablas de la base de datos";
    error(context, err);
  }

  return err;
}

Future<String> deleteDB(BuildContext context, String nameBD, conn) async {

  String err="";

  try {

    await conn.query('DROP DATABASE $nameBD');

  }catch(SQLException){

    err= "No se pudo eliminar la base de datos";
    error(context, err);
  }

  return err;
}

Future<String> editDB(BuildContext context, String nameBD, String nameBDnew) async {

  String err="";
  var showTablesVar = await conn.query('SHOW TABLES');
  String sTablesLine = showTablesVar.toString();
  String tmp= sTablesLine.substring(1,sTablesLine.length-1);

  List<String> allLine = tmp.split(":");
  List<String> nameTables = [];

  for(int i = 0; i < allLine.length; i++)
  {
    if(i%2 == 0)
    {
      List<String> allLine2 =allLine[i].split("}");
      nameTables.add(allLine2[0]);
    }

  }
  nameTables.removeAt(0);

  try {

    await conn.query('CREATE DATABASE $nameBDnew');

    for(int i = 0; i < nameTables.length; i++)
    {
      String nameTable = nameTables[i];
      await conn.query('RENAME TABLE $nameBD.$nameTable TO $nameBDnew.$nameTable');
    }

    await conn.query('DROP DATABASE $nameBD');

  }catch(SQLException){

    err = "Error al modificar el nombre ";
    error(context, err);
  }


  return err;
}