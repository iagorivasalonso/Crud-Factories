
import 'dart:convert';

import 'package:crud_factories/Objects/Mail.dart';
import 'package:http/http.dart' as http;

class Mailapi {

  static const baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> sendingMailApi (MessageMail messageMail) async {

    try{
          final body = messageMail.toJson();
          final response = await http.post(
            Uri.parse('$baseUrl/mail/send'),
            headers: {'Content-Type' :'application/json'},
            body: jsonEncode(body),
          );

          final responseData = response.body.isNotEmpty
                ? jsonDecode(response.body)
                : null;

          if(response.statusCode >= 200 && response.statusCode < 300)
          {
            // Ahora responseData['results'] es una lista de envíos
            final results = responseData['results'] as List<dynamic>? ?? [];

            final sentMails = results.where((r) => r['status'] == 'sent').toList();
            final failedMails = results.where((r) => r['status'] == 'failed').toList();

            String summary = 'Enviados: ${sentMails.length}, Fallidos: ${failedMails.length}';
            if (failedMails.isNotEmpty) {
              summary += '\nFallaron: ${failedMails.map((r) => r['mail']).join(', ')}';
            }
            return {'ok': sentMails.isNotEmpty, 'message': summary, 'results': results};
          }

          if(response.statusCode == 400)
          {
            return {
              'ok': false,
              'message': responseData?['message'] ?? 'Solicitud incorrecta'
            };
          }

          if(response.statusCode == 401)
          {
              return {
                'ok': false,
                'message': 'No autorizado'
              };
          }

          if(response.statusCode >= 500)
          {
            return {
              'ok': false,
              'message': 'Error interno del servidor'
            };
          }


          return {
            'ok': false,
            'message': "Error inesperado(${response.statusCode})"
          };
    } catch(e){
      return {'ok': false, 'message': 'Error de conexión: $e'};
    }
  }
}

