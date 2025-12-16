import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MailController {

  final TextEditingController mail;
  final TextEditingController password;
  final TextEditingController? passwordVerify;
  final TextEditingController? mailTo;
  final TextEditingController? subject;
  final TextEditingController? message;
  final List<PlatformFile> attachments;

  MailController({
    required this.mail,
    required this.password,
    this.passwordVerify,
    this.mailTo,
    this.subject,
    this.message,
    List<PlatformFile>? attachments,


  }) :attachments = attachments ?? [];

  bool get hasAttachments => attachments.isNotEmpty;
}
