import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/generated/l10n.dart';
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
    String title = S.of(context).list_of_sends;

    return Scaffold(
      appBar: appBarAndroid(context, name: title),
      body: Text("factori"),
    );
  }
}