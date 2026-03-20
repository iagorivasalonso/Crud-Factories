import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/src/widgets/framework.dart';

class manageState {

  static String parseState(String value, BuildContext context, bool chargueLines) {
    // Mapear los valores de string a estados
    final stateMap = <String, String>{
      S.of(context).prepared.toLowerCase(): S.of(context).prepared,
      S.of(context).sent.toLowerCase(): S.of(context).sent,
      S.of(context).in_progress.toLowerCase(): S.of(context).in_progress,
      S.of(context).returned.toLowerCase(): S.of(context).returned,
      S.of(context).he_responded.toLowerCase(): S.of(context).he_responded,
    };

    // Si es para cargar líneas, usar nombres de enum internos (LineSendState)
    if (chargueLines) {
      stateMap.clear();
      stateMap.addAll({
        "linesendstate.prepared": S.of(context).prepared,
        "linesendstate.sent": S.of(context).sent,
        "linesendstate.in_progress": S.of(context).in_progress,
        "linesendstate.returned": S.of(context).returned,
        "linesendstate.has_responded": S.of(context).he_responded,
      });
    }

    final key = value.toLowerCase().trim();
    return stateMap[key] ?? S.of(context).prepared;
  }

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

  LineSendState stringToState(String value) {
    final key = value.toLowerCase().trim();

    switch (key) {
      case "prepared":
      case "linesendstate.prepared":
        return LineSendState.prepared;

      case "sent":
      case "linesendstate.sent":
      case "enviado":
        return LineSendState.sent;

      case "in_progress":
      case "linesendstate.in_progress":
      case "en proceso":
        return LineSendState.in_progress;

      case "returned":
      case "linesendstate.returned":
        return LineSendState.returned;

      case "has_responded":
      case "he_responded":
      case "linesendstate.has_responded":
      case "respondido":
        //return LineSendState.heResponded;

      default:
        return LineSendState.prepared;
    }
  }

  }

