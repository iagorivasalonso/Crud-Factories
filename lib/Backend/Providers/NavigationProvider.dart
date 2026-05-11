
import 'package:fluent_ui/fluent_ui.dart';

enum AppView {
  home,

  createFactory,
  createMail,
  createShipment,

  importData,

  factories,
  mails,
  shipments,

  sendMail,
  connections,

}

class NavigationProvider extends ChangeNotifier {

   AppView _current = AppView.home;

   AppView get current => _current;

   String? sectorId;

   void go(
       AppView view, {
         String? sector,
       }) {

     _current = view;
     sectorId = sector;

     notifyListeners();
   }
}