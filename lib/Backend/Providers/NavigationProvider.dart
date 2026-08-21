
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Functions/changesNoSave.dart' show changesNoSave;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

enum AppView {
  home,

  createFactory,
  creataddress,
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

  void go(AppView view) {
    _current = view;
    notifyListeners();
  }

  Future<bool> canNavigate(BuildContext context) async {

    final provider = context.read<EditStateProvider>();

    if (!provider.hasChanges) return true;

    final ok = await changesNoSave(context);

    if (ok) {
      provider.clear();
    }

    return ok;

    notifyListeners();
  }
}

