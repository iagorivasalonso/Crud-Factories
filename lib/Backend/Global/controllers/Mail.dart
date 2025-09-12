import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class MailController {

  final TextEditingController mail;
  final TextEditingController password;
  final TextEditingController? passwordVerify;
  final TextEditingController? mailTo;
  final TextEditingController? subject;
  final TextEditingController? message;
  final List<File> attachments;

  MailController({
    required this.mail,
    required this.password,
    this.passwordVerify,
    this.mailTo,
    this.subject,
    this.message,
    List<File>? attachments,


  }) :attachments = attachments ?? [];

  bool get hasAttachments => attachments.isNotEmpty;
}
