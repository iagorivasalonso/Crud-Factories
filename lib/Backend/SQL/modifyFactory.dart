import 'dart:convert';

import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

Future<void> sqlModifyFActory(List<Factory> factory) async {


  try {

      final String id = factory[0].id;
      final String name = factory[0].name;
      final String highDate = factory[0].highDate;
      final String sector = factory[0].sector;
      final List<String> thelephones = factory[0].thelephones;
      final String mail = factory[0].mail;
      final String web = factory[0].web;
      final Map<String, dynamic> address = factory[0].address;

      if (!foundation.kIsWeb) {
        await executeQuery.query(
          'UPDATE factories SET name=?, highDate=?, sector=?, thelephones=?, mail=?, web=?, street=?, number=?, apartament=?, city=?, postalCode=?, province=? WHERE id=?',
          [
            name,
            highDate,
            sector,
            thelephones.join(','), // si tu DB almacena como texto
            mail,
            web,
            address['street'],
            address['number'],
            address['apartament'],
            address['city'],
            address['postalCode'],
            address['province'],
            id
          ],
        );
      } else {
        final uri = Uri.parse('http://localhost:3000/$selectedDb/factories/$id');
        final res = await http.put(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'highDate': highDate,
            'sector': sector,
            'thelephones': thelephones,
            'mail': mail,
            'web': web,
            'address': address,
          }),
        );

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }

    }

    print('Factories modificadas: ${factory.length}');
  } catch (e) {
    print('ERROR al modificar factories: $e');
  }
}
