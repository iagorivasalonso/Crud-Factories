import 'package:crud_factories/Functions/changesNoSave.dart' show changesNoSave;
import 'package:flutter/material.dart';


class EditStateProvider extends ChangeNotifier {

  bool _hasChanges = false;

  bool get hasChanges => _hasChanges;

  void markChanged() {
    _hasChanges = true;
    notifyListeners();
  }

  void clear() {
    _hasChanges = false;
    notifyListeners();
  }

  Future<bool> confirmDiscard(BuildContext context) async {

    if (!_hasChanges) return true;

    final ok = await changesNoSave(context);

    if (ok) {
      clear();
    }

    return ok;
  }
}