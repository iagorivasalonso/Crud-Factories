
import 'package:crud_factories/Objects/BaseEntity.dart';


class Mail extends BaseEntity {

   String id;
   String mail;
   String host;
   String port;
   bool secure;
   String password;

   Mail({
    required this.id,
    required this.mail,
    required this.host,
    required this.port,
    required this.secure,
    required this.password
   });
}

class MailResult {
  final bool success;
  final List<String> sent;
  final List<MailFailure> failed;

  MailResult({
    required this.success,
    required this.sent,
    required this.failed,
  });
}

class MailFailure {
  final String mail;
  final String error;

  const MailFailure({
    required this.mail,
    required this.error,
  });
}