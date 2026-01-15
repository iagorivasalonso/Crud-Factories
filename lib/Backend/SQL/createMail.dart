import 'dart:convert';
import 'dart:html' as html; // Solo se usa en web
import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';

Future<void> sqlCreateMail(List<Mail> mails) async {
  try {
    for (var mail in mails) {
      String id = mail.id;
      String company = mail.company;
      String email = mail.address;
      String password = mail.password;

      if (!foundation.kIsWeb) {
        // SQLite o base de datos nativa
        await executeQuery.query(
          'INSERT INTO mails (id, company, email, password) VALUES (?, ?, ?, ?)',
          [id, company, email, password],
        );
      } else {
        // Web: guardar en localStorage
        String key = 'mail_$id';
        Map<String, String> value = {
          'id': id,
          'company': company,
          'email': email,
          'password': password,
        };
        html.window.localStorage[key] = jsonEncode(value);
      }
    }

    print('Mails guardados correctamente.');
  } catch (e) {
    print('Error guardando mails: $e');
  }
}
