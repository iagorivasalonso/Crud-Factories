import 'dart:convert';

import 'package:crud_factories/Objects/BaseEntity.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:flutter/foundation.dart' show Uint8List;

class MailMessage {

  final List<String> recipients;
  final String subject;
  final String message;
  final List<MailAttachment> attachments;


  MailMessage({
        required this.recipients,
        required this.subject,
        required this.message,
        this.attachments = const[],
   });

   Map<String,dynamic> toJson () => {
     'mail': recipients,
     'subject': subject,
     'message': message,
     'attachments': attachments.map((e) => e.toJson()).toList(),
   };
}

class MailAttachment {
  final String name;
  final String? path;
  final Uint8List? bytes;

  const MailAttachment({
    required this.name,
    this.path,
    this.bytes,
  });

  Map<String, dynamic> toJson() => {
    'filename': name,
    'content': bytes != null ? base64Encode(bytes!) : null,
    'contentType': 'application/octet-stream',
  };
}

class ApiMailRequest {

   final Mail mail;
   final MailMessage message;

   ApiMailRequest({
      required this.mail,
      required this.message,
   });

   Map<String, dynamic> toJson() => {
     'host': mail.host,
     'port': mail.port,
     'secure': mail.secure,
     'username': mail.mail,
     'password': mail.password,
         ...message.toJson()
   };
}
