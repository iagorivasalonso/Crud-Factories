
import '../Frontend/importData.dart';

class Mail extends BaseEntity {

   String id;
   String address;
   String company;
   String password;

   Mail({
    required this.id,
    required this.address,
    required this.company,
    required this.password
   });
}

class MessageMail extends BaseEntity {

  final String host;
  final int port;
  final bool secure;
  final String username;
  final String password;
  final List<dynamic> mails;
  final String subject;
  final String message;
  final List<Map<String, dynamic>>? attachments;

  MessageMail ({
    required this.host,
    required this.port,
    required this.secure,
    required this.username,
    required this.password,
    required this.mails,
    required this.subject,
    required this.message,
    this.attachments
  });

  Map<String, dynamic> toJson() => {
    'host': host,
    'port': port,
    'secure': secure,
    'username': username,
    'password': password,
    'mail': mails,
    'subject': subject,
    'message': message,
    'attachments': attachments
  };
}