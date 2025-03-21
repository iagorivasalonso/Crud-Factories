import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

class appAndroid extends StatefulWidget {

  BuildContext context;

  appAndroid(this.context);

  @override
  State<appAndroid> createState() => _appAndroidState();
}

class _appAndroidState extends State<appAndroid> {


  @override
  Widget build(BuildContext context) {

    BuildContext context = this.context;

    return Scaffold(
      appBar: AppBar(
        title: Text("prhjb  nmue"),
      ),
      drawer:  Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
                child: Text("head"),
                decoration: BoxDecoration(
                  color: Colors.red
                ) ,
            ),
            ExpansionTile(
              title: Text(S.of(context).newMale),
              children: <Widget>[
                    ListTile(
                      title: Text(S.of(context).company),
                      onTap: () {
                        Navigator.pop(context); // Cierra el Drawer
                        // Navegar o realizar alguna acción
                      },
                    ),
                    ListTile(
                      title: Text(S.of(context).mail),
                      onTap: (){

                      },
                    ),
                    ListTile(
                      title: Text(S.of(context).shipment),
                      onTap: (){

                      },
                    ),
                  ]
                ),
            ListTile(
              title: Text(S.of(context).routes),
              onTap: (){

              },
            ),
            ListTile(
              title: Text(S.of(context).import),
              onTap: (){

              },
            ),
            ExpansionTile(
                title: Text(S.of(context).lists),
                children: <Widget>[
                  ListTile(
                    title: Text(S.of(context).sectors),
                    onTap: () {
                      Navigator.pop(context); // Cierra el Drawer
                      // Navegar o realizar alguna acción
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).company),
                    onTap: () {
                      Navigator.pop(context); // Cierra el Drawer
                      // Navegar o realizar alguna acción
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).mail),
                    onTap: (){

                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).shipment),
                    onTap: (){

                    },
                  ),
                ]
            ),
            ListTile(
              title: Text(S.of(context).DB_connection),
              onTap: (){

              },
            ),
            ListTile(
              title: Text(S.of(context).sending_mails),
              onTap: (){

              },
            ),
            ListTile(
              title: Text(S.of(context).go_out),
              onTap: (){

              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have push:',
            ),

          ],
        ),
      ),

    );
  }
}