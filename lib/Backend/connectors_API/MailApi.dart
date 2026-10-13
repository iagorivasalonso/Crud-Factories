
import 'dart:convert';
import 'package:crud_factories/Backend/connectors_API/ApiConfigUrl.dart';
import 'package:crud_factories/Objects/MailMessage.dart' show ApiMailRequest;
import 'package:http/http.dart' as http;

class MailApi {

  static String get baseUrl => ApiConfigUrl.baseUrl;

  static Future<Map<String, dynamic>> send(ApiMailRequest request) async {

          final response = await http.post(
            Uri.parse('$baseUrl/mail/send'),
            headers:  const{
              'Content-Type' :'application/json'
            },
            body: jsonEncode(request.toJson()),
          );

            return {
              'statusCode': response.statusCode,
              'body': response.body.isNotEmpty
                     ? jsonDecode(response.body)
                     : null,
            };
          }
}


