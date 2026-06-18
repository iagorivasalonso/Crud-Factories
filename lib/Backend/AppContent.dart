import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Frontend/Views/listFactories.dart' show listFactories;
import 'package:crud_factories/Frontend/conection.dart';
import 'package:crud_factories/Frontend/factory.dart' show FactoryFromPage;
import 'package:crud_factories/Objects/Conection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppContent extends StatelessWidget {
  const AppContent({super.key});

  @override
  Widget build(BuildContext context) {

     final nav = context.watch<NavigationProvider>();
print(nav.current);
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
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("FACTORIES"),
           ),
         );
       case AppView.createFactory:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("nuFACTORIES"),
           ),
         );
         throw UnimplementedError();
       case AppView.createMail:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("nuMail"),
           ),
         );

       case AppView.createShipment:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("nuSend"),
           ),
         );

       case AppView.importData:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("import"),
           ),
         );

       case AppView.mails:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("maillist"),
           ),
         );
       case AppView.shipments:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("envlist"),
           ),
         );
       case AppView.sendMail:
         return Container(
           color: Colors.white,
           child: const Center(
             child: Text("env;ail"),
           ),
         );
       case AppView.connections:
         return conection();
     }

  }
}


