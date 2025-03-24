

import 'package:crud_factories/Frontend/Android/listMails.dart';
import 'package:crud_factories/Frontend/Android/listSends.dart';
import 'package:crud_factories/Frontend/adminRoutes.dart';
import 'package:crud_factories/Frontend/adminSectors.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/factory.dart';
import 'package:crud_factories/Frontend/importData.dart';
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import '../../Frontend/Android/listFactories.dart';

Map<String,WidgetBuilder> getAppRoutes() {

  int select=-1;

  return {
    '/factory' :(context) => newFactory(context,select),
    '/mail' :(context) => newMail(context, select),
    '/send' :(context) =>  newSend(context,"", "", select),
    '/importData' :(context) => newImport(context),
    '/listSectors' :(context) => adminSectorAndroid(context),
    '/listRoutes' :(context) => adminRoutesAndroid(context),
    '/listFactories' :(context) => listFactories(context) ,
    '/listMails' :(context) => listMails(context),
    '/listSends' :(context) => listSends(context),
    '/conectionDB' :(context) => conection(context),
    '/sendMail' :(context) => sendMail(context),
    '/exit' :(context) {
        SystemNavigator.pop();
        return const SizedBox ();
     },
  };
}