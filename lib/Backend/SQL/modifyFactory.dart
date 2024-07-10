import 'package:crud_factories/Backend/SQL/importFactories.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Factory.dart';

Future<void> sqlModifyFActory(List<Factory> factories) async {

  try{


    String id = factories[0].id;
    String name = factories[0].name;
    String highDate = factories[0].highDate;
    String telephone1 = factories[0].thelephones[0];
    String telephone2 = factories[0].thelephones[1];
    String mail = factories[0].mail;
    String web = factories[0].web;
    String address = factories[0].address['street'].toString();
    String number = factories[0].address['number'].toString();
    String apartament = factories[0].address['apartament'].toString();
    String city = factories[0].address['city'].toString();
    String province = factories[0].address['province'].toString();
    String postalCode = factories[0].address['postalCode'].toString();
    String empleoyes =factories[0].contacts.toString();

    var result = await conn.query('update factories set name=?,highDate=?,telephone1=?,telephone2=?,mail=?,web=?,address=?,number=?,apartament=?,city=?,province=?,postalcode=?,empleoyes=? where id=?', [name,highDate, telephone1, telephone2,mail,web, address, number, apartament,city,province,postalCode,empleoyes, id]);


  } catch(SQLExeption){


  }
}

