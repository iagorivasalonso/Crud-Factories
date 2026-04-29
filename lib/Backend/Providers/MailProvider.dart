import 'dart:typed_data';

import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Objects/Mail.dart' show Mail;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_html/html.dart' show File;

class MailProvider  extends ChangeNotifier {

  final List<Mail> _mails = [];

  List<Mail> get mails => List.unmodifiable(_mails);

  void setMails(List<Mail> data) {
    _mails
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  void addMail(Mail mail) {
    _mails.add(mail);
    notifyListeners();
  }

  void delete(Mail mail) {
    _mails.remove(mail);
    notifyListeners();
  }

  void clear() {
    _mails.clear();
    notifyListeners();
  }
  Future<void> importMails(BuildContext context, {
    required File file,
    Uint8List? bytes,
    String? content,
    String? assetPath,
  }) async {
    try {
      final imported = await csvImportMails(
        file: fMails,
        bytes: bytes,
        content: content,
        assetPath: assetPath,
      );

      _mails.addAll(imported); // ✔ estado del provider
    } catch (e) {
      final s = S.of(context);

      final msg = e.toString().toLowerCase();

      if (msg.contains("not found") ||
          msg.contains("archivo") ||
          msg.contains("asset")) {
        errorFiles.add("${s.file_not_found} ${s.routes}");
      } else {
        errorFiles.add("${s.file_format_error} ${s.routes}");
      }
    }

    notifyListeners();
  }

}