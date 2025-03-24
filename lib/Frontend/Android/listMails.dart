import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';

class listMails extends StatefulWidget {

  BuildContext context;

  listMails(this.context);

  @override
  State<listMails> createState() => _listMailsState();
}

class _listMailsState extends State<listMails> {
  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;
    String title = S.of(context).list_of_emails;

    return Scaffold(
      appBar: appBarAndroid(context, name: title),
      body: Text("factori"),
    );

  }
}
