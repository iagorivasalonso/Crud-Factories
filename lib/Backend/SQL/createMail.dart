import 'package:flutter/foundation.dart' as foundation;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Mail.dart';

import '../connectors_API/saveToWebStorage.dart';


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
        saveToWebStorage(
          'mails', // prefijo
          id,     // id único de la línea
          {
            'id': id,
            'company': company,
            'email': email,
            'password': password,
          },
        );
      }
    }

    print('Mails guardados correctamente.');
  } catch (e) {
    print('Error guardando mails: $e');
  }
}
