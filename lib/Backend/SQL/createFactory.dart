import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Factory.dart';

Future<void> sqlCeateFactory(List<Factory> factories) async {

   try{

       for(int i = 0; i < factories.length; i++)
       {
          String id = factories[i].id;
          String name = factories[i].name;
          String highDate = factories[i].highDate;
          String sector = factories[i].sector;
          String telephone1 = factories[i].thelephones[0];
          String telephone2 = factories[i].thelephones[1];
          String mail = factories[i].mail;
          String web = factories[i].web;
          String address = factories[i].address['street'].toString();
          String number = factories[i].address['number'].toString();
          String apartament = factories[i].address['apartament'].toString();
          String city = factories[i].address['city'].toString();
          String province = factories[i].address['province'].toString();
          String postalCode = factories[i].address['postalCode'].toString();

          var result = await conn.query(
              'insert into factories (id,name,highDate,sector,telephone1,telephone2,mail,web,address,number,apartament,city,province,postalcode) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
              [id,name,highDate,sector,telephone1,telephone2,mail,web,address,number,apartament,city,province,postalCode]);
       }

   } catch(SQLExeption) {

   }
}

