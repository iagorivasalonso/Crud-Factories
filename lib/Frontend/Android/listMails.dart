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

    return Scaffold(
      body: Text("mails"),
    );

  }
}
