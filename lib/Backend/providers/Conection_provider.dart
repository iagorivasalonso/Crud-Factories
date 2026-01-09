import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mysql1/mysql1.dart';

import '../../Alertdialogs/confirm.dart';
import '../../Alertdialogs/error.dart';
import '../../generated/l10n.dart';

enum ConnectionStatus {

  none,
  disconnected,
  connected,
}
class ConectionProvider extends ChangeNotifier {

  Conection? selected;



  ConnectionStatus get status {
    if(selected == null) return ConnectionStatus.none;
    return executeQuery == null
        ? ConnectionStatus.disconnected
        : ConnectionStatus.connected;
  }

  String actionLabel(BuildContext context) {
     switch(status) {
       case ConnectionStatus.none:
         return S.of(context).newFemale;
       case ConnectionStatus.disconnected:
         return S.of(context).connect;
       case ConnectionStatus.connected:
         return S.of(context).disconnect;
     }

  }

  Future<void> selectConnection(Conection? c, BuildContext context) async {
    if (status == ConnectionStatus.connected) {
      await disconnet(context);
    }
    selected = c;
    executeQuery = null;
    notifyListeners();
  }

  Future<void> connect (BuildContext context) async {
    if (selected == null) return;

    final settings = ConnectionSettings(
      host: selected!.host,
      port: int.parse(selected!.port),
      user: selected!.user,
      password: selected!.password,
      db: selected!.database,
    );

    try {
      executeQuery = await MySqlConnection.connect(settings);
      BaseDateSelected = selected!.database;

      selectedDb =  selected!.database;

      confirm(context, '${S
          .of(context)
          .is_connected_to} ${selected!.database}');
      notifyListeners();
    } catch (e) {
      error(context, S
          .of(context)
          .sql_error);
    }
  }
    Future<void>disconnet(BuildContext context) async {

      await executeQuery?.close();
      confirm(context, S.of(context).has_closed_the_connection);
      selectedDb='';
      selected = null;
      notifyListeners();
    }

    void clearSelection() {

      selected = null;
      executeQuery = null;

      notifyListeners();
    }
  }
