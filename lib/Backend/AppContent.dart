import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Frontend/Views/listFactories.dart' show listFactories;
import 'package:crud_factories/Frontend/Views/listSends.dart';
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/factory.dart' show FactoryFromPage;
import 'package:crud_factories/Frontend/importData.dart' show NewImport;
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/Frontend/send_mail.dart';
import 'package:crud_factories/Objects/Conection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Frontend/Views/listMails.dart';

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {

     final nav = context.watch<NavigationProvider>();

     switch(nav.current)
     {
       case AppView.home:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("Home"),
           ),
         );

       case AppView.factories:
         return listFactories();

       case AppView.createFactory:
         return FactoryFromPage();

       case AppView.creataddress:
         return MailFormPage();

       case AppView.createShipment:
         return SendFromPage();

       case AppView.importData:
         return NewImport();

       case AppView.mails:
         return listMails();

       case AppView.shipments:
         return listSends();

       case AppView.sendMail:
         return SendMail();

       case AppView.connections:
         return conection();
     }

  }
}



