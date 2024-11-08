import 'package:flutter/src/widgets/framework.dart';

import '../Alertdialogs/warning.dart';

Future<bool> changesNoSave(BuildContext context) async {

  String mensaje = 'Todos los cambios se perderan ¿Desea continuar?';
  bool changes = await warning(context, mensaje);


  return changes;
}