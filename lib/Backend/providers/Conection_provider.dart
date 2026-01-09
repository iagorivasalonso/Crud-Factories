import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mysql1/mysql1.dart';

import '../../Alertdialogs/confirm.dart';
import '../../Alertdialogs/error.dart';
import '../../generated/l10n.dart';

enum ConectionStatus {

  none,
  disconnected,
  connected,
}
class ConectionProvider extends ChangeNotifier {

  Conection? selected;
  MySqlConnection? connection;

  ConectionStatus get status {
    if(selected == null) return ConectionStatus.none;
    return connection == null
        ? ConectionStatus.connected
        : ConectionStatus.connected;
  }

  String actionLabel(BuildContext context) {
     switch(status) {
       case ConectionStatus.none:
         return S.of(context).newFemale;
       case ConectionStatus.disconnected:
         return S.of(context).connect;
       case ConectionStatus.connected:
         return S.of(context).disconnect;
     }

  }

  void selectedConnection (Conection? c) {
    selected = c;
    notifyListeners();
  }

  Future<void> connect (BuildContext context) async {

    if(selected == null) return;

    final settings = ConnectionSettings(
      host: selected!.host,
      port: int.parse(selected!.port),
      user: selected!.user,
      password: selected!.password,
      db: selected!.database,
    );

    try {
       connection = await MySqlConnection.connect(settings);
       BaseDateSelected = selected!.database;

       confirm(context, '${S.of(context).is_connected_to} ${selected!.database}');
       notifyListeners();

    } catch (e) {
      error(context, S.of(context).sql_error);
    }

    Future<void>disconnet(BuildContext context) async {

      await connection?.close();

      confirm(context, S.of(context).has_closed_the_connection);
      notifyListeners();
    }

    void clearSelection() {

      selected = null;
      connection = null;

      notifyListeners();
    }
  }
}