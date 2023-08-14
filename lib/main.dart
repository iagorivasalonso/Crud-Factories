import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'Screens/navigation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: "Test",
      home: MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  State<MyApp1> createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> with WindowListener {
/*
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }
*/
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Materialapp',
      home: NavigationScreen(),
    );
  }/*
  @override
  void onWindowClose() async {
    print("object");
    testAlert();
    bool _isPreventClose = await windowManager.isPreventClose();

  }

  void testAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Test"),
            content: Text("Done..!"),
          );

        });
  }
  */
}