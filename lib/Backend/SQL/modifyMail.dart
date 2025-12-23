import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import '../../Objects/Mail.dart';
import '../Global/variables.dart';

Future<void> sqlModifyMail(List<Mail> mail) async {

  try {

      final String id = mail[0].id;
      final String address = mail[0].address;
      final String company = mail[0].company;
      final String password = mail[0].password;

      if (!foundation.kIsWeb) {
        await executeQuery.query(
          'UPDATE mails SET address=?, company=?, password=? WHERE id=?',
          [address, company, password, id],
        );
      } else {
        final uri = Uri.parse('http://localhost:3000/$selectedDb/mails/$id');
        final res = await http.put(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'address': address,
            'company': company,
            'password': password,
          }),
        );

        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}: ${res.body}');
        }
      }


    print('Mails modificados: ${mail.length}');
  } catch (e) {
    print('ERROR al modificar mails: $e');
  }
}
