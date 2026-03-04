
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

  String host;
  int port;
  bool secure;
  String username;
  String password;
  List<dynamic> mails;
  String subject;
  String message;

  MessageMail ({
    required this.host,
    required this.port,
    required this.secure,
    required this.username,
    required this.password,
    required this.mails,
    required this.subject,
    required this.message
  });

  Map<String, dynamic> toJson() => {
    'host': host,
    'port': port,
    'secure': secure,
    'username': username,
    'password': password,
    'mail': mails,
    'subject': subject,
    'message': message
  };
}