

import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/Feature/Mail/IMailDataSource.dart';
import 'package:crud_factories/Backend/Feature/Mail/exportMail.dart';
import 'package:crud_factories/Backend/Feature/Mail/importMail.dart' show csvImportMails;
import 'package:crud_factories/Objects/Mail.dart';

class CsvMailDatasource implements IMailDataSource {

  final String path;

  CsvMailDatasource(this.path);

  @override
  Future<List<Mail>> load() async {

    return await csvImportMails(
       assetPath: this.path
    );
  }

  @override
  Future<void> delete(String id) async {
     final mails = await load();

     final update = mails.where((m) => m.id != id).toList();

     await csvExportatorMails(
         update,
         path: path
     );
  }

  @override
  Future<void> insert(Mail mail) async {
    final mails = await load();

    final update = [
         ...mails.where((m) => m.id !=mail.id),
         mail
      ];

    await csvExportatorMails(
        update,
        path: path
    );
  }



  @override
  Future<void> upload(Mail mail) async {
    final mails = await load();

     final index = mails.indexWhere((m) => m.id == mail.id);

    if (index == -1) {
      throw Exception('Mail con id ${mail.id} no encontrado');
    }

    mails[index] = mail;

    await csvExportatorMails(
        mails,
        path: path
      );
  }
}