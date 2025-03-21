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

    return Scaffold(
      body: Text("factorikidrf"),
    );

  }
}
