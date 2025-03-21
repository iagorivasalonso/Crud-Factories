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
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,'/factory',arguments: -1);
                      },
                    ),
                    ListTile(
                      title: Text(S.of(context).mail),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,'/mail', arguments: -1);
                      },
                    ),
                    ListTile(
                      title: Text(S.of(context).shipment),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,'/sendMail', arguments: -1);
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
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'/importData');
              },
            ),
            ExpansionTile(
                title: Text(S.of(context).lists),
                children: <Widget>[
                  ListTile(
                    title: Text(S.of(context).sectors),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).company),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context,'/listFactories');
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).mail),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context,'/listMails');
                    },
                  ),
                  ListTile(
                    title: Text(S.of(context).shipment),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context,'/listSends');
                    },
                  ),
                ]
            ),
            ListTile(
              title: Text(S.of(context).DB_connection),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'/conection');
              },
            ),
            ListTile(
              title: Text(S.of(context).sending_mails),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'/sendMail');
              },
            ),
            ListTile(
              title: Text(S.of(context).go_out),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context,'/exit');
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