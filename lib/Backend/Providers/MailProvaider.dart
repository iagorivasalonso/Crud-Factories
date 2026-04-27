import 'package:fluent_ui/fluent_ui.dart';

class Mailprovaider  extends ChangeNotifier {

  final List<String> _mails = [];

  List<String> get mails => List.unmodifiable(_mails);

  void setMails(List<String> data) {
    _mails
      ..clear()
      ..addAll(List.from(data));

    notifyListeners();
  }

  void addMail(String mail) {
    _mails.add(mail);
    notifyListeners();
  }

  void delete(String mail) {
    _mails.remove(mail);
    notifyListeners();
  }

  void clear() {
    _mails.clear();
    notifyListeners();
  }
}