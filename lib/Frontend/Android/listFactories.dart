import 'package:crud_factories/Widgets/headViewsAndroid.dart' show appBarAndroid;
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';

class listFactories extends StatefulWidget {

  BuildContext context;

  listFactories(this.context);

  @override
  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {
  @override
  Widget build(BuildContext context) {

    BuildContext context = widget.context;
    String title = S.of(context).list_of_companies;

    return Scaffold(
      appBar: appBarAndroid(context, name: title),
      body: Text("factori"),
    );

  }
}
