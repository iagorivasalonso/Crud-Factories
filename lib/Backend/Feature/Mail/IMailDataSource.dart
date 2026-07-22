
import 'package:crud_factories/Objects/Mail.dart';

abstract class IMailDataSource {

    Future<List<Mail>> load();

    Future<void> insert(Mail mail);

    Future<void> delete(String id);

    Future<void> upload(Mail mail);

}