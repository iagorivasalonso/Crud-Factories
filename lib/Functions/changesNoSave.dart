import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:flutter/src/widgets/framework.dart';


Future<bool> changesNoSave(BuildContext context) async {

  String message = S.of(context).all_changes_will_be_lost_do_you_want_to_continue;
  bool changes = await warning(context, message);


  return changes;
}