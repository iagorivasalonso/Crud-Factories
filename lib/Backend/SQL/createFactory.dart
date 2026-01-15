import 'dart:convert';
import 'dart:html' as html; // Solo se usa en web
import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Factory.dart';

Future<void> sqlCreateFactory(List<Factory> factories) async {
   try {
      for (var factory in factories) {
         String id = factory.id;
         String name = factory.name;
         String highDate = factory.highDate;
         String sector = factory.sector;
         String telephone1 = factory.thelephones[0];
         String telephone2 = factory.thelephones[1];
         String mail = factory.mail;
         String web = factory.web;
         String address = factory.address['street'].toString();
         String number = factory.address['number'].toString();
         String apartament = factory.address['apartament'].toString();
         String city = factory.address['city'].toString();
         String province = factory.address['province'].toString();
         String postalCode = factory.address['postalCode'].toString();

         if (!foundation.kIsWeb) {
            // SQLite o base de datos nativa
            await executeQuery.query(
               'INSERT INTO factories (id,name,highDate,sector,telephone1,telephone2,mail,web,address,number,apartament,city,province,postalcode) '
                   'VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
               [id, name, highDate, sector, telephone1, telephone2, mail, web, address, number, apartament, city, province, postalCode],
            );
         } else {
            // Web: guardar en localStorage
            String key = 'factory_$id';
            Map<String, dynamic> value = {
               'id': id,
               'name': name,
               'highDate': highDate,
               'sector': sector,
               'telephone1': telephone1,
               'telephone2': telephone2,
               'mail': mail,
               'web': web,
               'address': {
                  'street': address,
                  'number': number,
                  'apartament': apartament,
                  'city': city,
                  'province': province,
                  'postalCode': postalCode,
               },
            };
            html.window.localStorage[key] = jsonEncode(value);
         }
      }

      print('Factories guardadas correctamente.');
   } catch (e) {
      print('Error guardando factories: $e');
   }
}
