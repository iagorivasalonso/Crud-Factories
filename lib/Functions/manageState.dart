import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';

class manageState {


  static String seeLanguage (BuildContext context, option){
     
      final localizations = S.of(context);

      String state = localizations.pending;

           if (option == localizations.prepared || option =="prepared") {
               state = localizations.prepared;
            } else if (option == localizations.sent || option =="sent") {
              state = localizations.sent;
            } else if (option == localizations.in_progress || option =="in_progress") {
              state = localizations.in_progress;
            } else if (option == localizations.returned || option =="returned") {
              state = localizations.returned;
            } else if (option == localizations.he_responded  || option =="has_responded") {
              state = localizations.he_responded;
            } else {
              return state;
            }
            return state;
          }

  static LineSendState stringToState(String value) {
    switch (value.trim().toLowerCase()) {
      case "preparad":
        return LineSendState.prepared;
      case "pending":
        return LineSendState.pending;
      case "sent":
        return LineSendState.sent;
      case "in_progress":
        return LineSendState.in_progress;
      case "returned":
        return LineSendState.returned;
      case "has_returned":
        return LineSendState.has_responded;
      default:
        return LineSendState.prepared;
    }
  }

  }

