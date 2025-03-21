import 'package:flutter/material.dart';

class listSends extends StatefulWidget {

  BuildContext context;

  listSends(this.context);

  @override
  State<listSends> createState() => _listSendsState();
}

class _listSendsState extends State<listSends> {


  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;

    return Scaffold(
      body: Text("listsend"),
    );
  }
}