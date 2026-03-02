
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
  String secure;
  String mailTo;
  String mail;
  String message;

  MessageMail ({
    required this.host,
    required this.port,
    required this.secure,
    required this.mailTo,
    required this.mail,
    required this.message
  });

  Map<String, dynamic> toJson() => {
    'host': host,
    'port': port,
    'secure': secure,
    'mailTo': mailTo,
    'mail': mail,
    'message': message
  };
}