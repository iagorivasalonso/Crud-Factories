import 'package:flutter/material.dart';

AppBar appBarAndroid(BuildContext context , {

  required String name}) {

  return AppBar(
    backgroundColor: Colors.lightBlueAccent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushReplacementNamed(context,'/');
      },
    ),
    title: Text(name),
  );
}