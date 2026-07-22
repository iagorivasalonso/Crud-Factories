import 'dart:typed_data';

import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Feature/Mail/Service/ImailService.dart';
import 'package:crud_factories/Backend/Feature/Mail/Service/NativeMailService.dart';
import 'package:crud_factories/Backend/Global/files.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Repositories/mailRepository.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Objects/Mail.dart' show Mail, MailResult, MailFailure;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:universal_html/html.dart' show File;

import '../../Objects/MailMessage.dart';

class MailProvider  extends ChangeNotifier {

  final IMailService mailService;

  MailRepository? repository;

  List<Mail> _mails = [];
  Mail? selected;


  MailProvider(this.mailService);

  List<Mail> get mails => List.unmodifiable(_mails);

  // =========================
  // LOAD
  // =========================

  Future<void> load() async {
    try {
      final data = await _repo.load();

      _mails = data;

      notifyListeners();
    } catch (e) {
      print("Error cargando mails: $e");
      _mails = [];
      notifyListeners();
    }
  }

  // =========================
  // SELECT
  // =========================

  void select(Mail? m) {

    selected = m;
    notifyListeners();
  }

  // =========================
  //  SETMAILS
  // =========================

  void setMails(List<Mail> data) {

    _mails
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  // =========================
  //  ADDMAILS
  // =========================

  void addMail(Mail mail) {
    _mails.add(mail);
    notifyListeners();
  }

  // =========================
  //  EXISTSMAILS
  // =========================

  bool exist(String mail, {String? exclude}) {
    final mailAddressLower = mail.toLowerCase();

    return _mails.any((m) {
      final mailName = m.mail.toLowerCase();

      if (exclude != null && mailName == exclude.toLowerCase()) {
        return false;
      }

      return mailName == mailAddressLower;
    });
  }

  // =========================
  //  CLEAR
  // =========================

  void clear() {
     _mails.clear();
     notifyListeners();
  }

  // =========================
  //  GETREPO
  // =========================

  MailRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }

  // =========================
  //  RELOAD REPO
  // =========================

 Future<void> setRepositoryAndReload(MailRepository repo) async {

    repository = repo;
    _mails = [];
    notifyListeners();

    await load();
 }

  // =========================
  //  CREATE
 // =========================

Future<CreateResult> create (Mail mail) async {

    final address = mail.mail?.trim();

    if(address == null || mail.mail.isEmpty){
         return CreateResult.invalidData;
    }

     final exits = exist(address);

    if (exits) {
        return CreateResult.alreadyExists;
    }

   final idNew = mails.isNotEmpty
         ? createId(mails.last.id)
         : "1";

    final newMail = Mail(
        id: idNew,
        mail: mail.mail,
        host: mail.host,
        port: mail.port,
        secure: mail.secure,
        password: mail.password
    );

    _mails.add(newMail);
    notifyListeners();
    await _repo.insert(newMail);

    return CreateResult.success;
}

Future<EditResult> update(Mail update) async {

    if(update.mail.trim().isEmpty) {
       return EditResult.invalidData;
    }

    final address = update.mail.trim();

    final index = _mails.indexWhere((m) => m.id == update.id);
    if (index == -1) {
      return EditResult.notFound;
    }

    final oldMail = _mails[index];

    if(exist(address,exclude: oldMail.mail)) {
       return EditResult.alreadyExists;
    }

    final newMail = Mail(
        id: update.id,
        mail: update.mail,
        host: update.host,
        port: update.port,
        secure: update.secure,
        password: update.password
    );

    _mails[index] = newMail;

    notifyListeners();

    await _repo.upload(newMail);
    return EditResult.success;
}


  // =========================
  //  DELETE
  // =========================

  Future<DeleteResult> delete(
      String id,
      ) async {

    final index = _mails.indexWhere((m) => m.id == id);


    if (index == -1) {
      return DeleteResult.notFound;
    }

    final removed = _mails[index];

    _mails.removeAt(index);
    notifyListeners();

    try {
      await _repo.delete(id);
      return DeleteResult.success;
    } catch (e) {
      // rollback
      _mails.insert(index, removed);
      notifyListeners();
      return DeleteResult.notFound;
    }
  }

  Future<MailResult> send(
      MailMessage message,
      {Mail? account,required String noAccountMessage}
      ) async {

  if (selected == null) {
    return MailResult(
      success: false,
      sent: const [],
      failed: [
        MailFailure(
          error: noAccountMessage,
        ),
      ],
    );
  }

  return mailService.send(selected!, message);
}
























  }

