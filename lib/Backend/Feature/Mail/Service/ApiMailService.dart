import 'dart:convert';
import 'dart:io';

import 'package:crud_factories/Backend/Feature/Mail/Service/ImailService.dart' show IMailService;
import 'package:crud_factories/Backend/connectors_API/MailApi.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Objects/MailMessage.dart';

class ApiMailService  implements IMailService{

  @override
  Future<MailResult> send(Mail mail, MailMessage message) async{

      try {

         final request = ApiMailRequest(
                mail: mail,
                message: message,
         );

        final response = await MailApi.send(request);

         final statusCode = response['statusCode'] as int;
         final body = response['body'] as Map<String, dynamic>;

        if (statusCode >= 200 && statusCode < 300)
        {
             final results = body['results'] as List<dynamic>;

             final sent = <String>[];
             final failed = <MailFailure>[];

             for (final item in results) {

               final result = item as Map<String, dynamic>;

               if (result['status'] == 'sent') {
                 sent.add(result['mail']);
               } else {
                 failed.add(
                   MailFailure(
                     mail: result['mail'],
                     error: result['info'] ?? 'Error al enviar',
                   ),
                 );
               }
             }

             return MailResult(
               success: failed.isEmpty,
               sent: sent,
               failed: failed,
             );
        }

         return MailResult(
           success: false,
           sent: const [],
           failed: [
             MailFailure(
               mail: '',
               error: body?['message'] ?? 'Error HTTP $statusCode',
             ),
           ],
         );

      } catch (e) {

          return MailResult(
              success: false ,
              sent: const [],
              failed: [
                MailFailure(
                  mail: '',
                  error: e.toString(),
                ),
              ]
          );
      }
  }
}