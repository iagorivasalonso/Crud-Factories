import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';

class manageState {

  static LineSendState parseState(String value, BuildContext context, bool chargueLines) {
    LineSendState result = LineSendState.pending;

    String prepared = S.of(context).prepared.toLowerCase();
    String sent = S.of(context).sent.toLowerCase();
    String inProgress = S.of(context).in_progress.toLowerCase();
    String returned = S.of(context).returned.toLowerCase();
    String heResponded = S.of(context).he_responded.toLowerCase();


    if (chargueLines) {
      sent = "linesendstate.prepared";
      sent = "linesendstate.sent";
      inProgress = "linesendstate.in_progress";
      returned = "linesendstate.returned";
      heResponded = "linesendstate.has_responded";
    }


    String valueLower = value.toLowerCase().trim();

    if (valueLower == prepared) {
      result = LineSendState.prepared;
    } else if (valueLower == sent) {
      result = LineSendState.sent;
    } else if (valueLower == inProgress) {
      result = LineSendState.in_progress;
    } else if (valueLower == returned) {
      result = LineSendState.returned;
    } else if (valueLower == heResponded) {
      result = LineSendState.has_responded;
    }

    return result;
  }

  static String seeLanguage (BuildContext context, option){{
     
      final localizations = S.of(context);

      String state = localizations.pending;

           if (option == localizations.prepared || option =="LineSendState.prepared") {
               state = localizations.prepared;
            } else if (option == localizations.sent || option =="LineSendState.sent") {
              state = localizations.sent;
            } else if (option == localizations.in_progress || option =="LineSendState.in_progress") {
              state = localizations.in_progress;
            } else if (option == localizations.returned || option =="LineSendState.returned") {
              state = localizations.returned;
            } else if (option == localizations.he_responded  || option =="LineSendState.he_responded") {
              state = localizations.he_responded;
            } else {
              return state;
            }
            return state;
          }

  }
}
