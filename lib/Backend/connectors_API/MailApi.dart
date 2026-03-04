
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
              return {
                'ok': true,
                'message': responseData?['message'] ?? 'Correo enviado correctamente'
              };
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

