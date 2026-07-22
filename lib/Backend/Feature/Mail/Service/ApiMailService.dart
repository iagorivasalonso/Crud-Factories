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

        final attachments = <Map<String, dynamic>>[];

        for (final attachment in message.attachments) {



            attachments.add({
              'filename': attachment.name,
              'content': base64Encode(attachment.bytes!),
              'contentType': 'application/octet-stream',
            });
        }

         final request = ApiMailRequest(
                mail: mail,
                message: message,
                attachments: attachments
         );

        final response = await MailApi.send(request);

        final statusCode = response['statusCode'] as int;
        final body = response['body'];

        if (statusCode >= 200 && statusCode < 300)
        {
             final results = body as List<dynamic>;

             final sent = <String>[];
             final failed = <MailFailure>[];

             for (final item in results) {

               final result = item as Map<String, dynamic>;

               if (result['status'] == 'sent') {
                 sent.add(result['address']);
               } else {
                 failed.add(
                   MailFailure(
                     mail: result['address'],
                     error: result['message'] ?? 'Error al enviar',
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
              body?['message']  ?? 'Error HTTP $statusCode'
            ]
        );

      } catch (e) {

          return MailResult(
              success: false ,
              sent: const [],
              failed: [
                MailFailure(
                  error: e.toString(),
                ),
              ]
          );
      }
  }
}