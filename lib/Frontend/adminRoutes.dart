
import 'dart:io';

import 'package:flutter/material.dart';

import '../Backend/Global/controllers/Router.dart';
import '../Backend/Global/list.dart';
import '../Backend/Global/variables.dart';
import '../Widgets/CSVPickerField.dart';
import '../Widgets/headAlertDialog.dart';
import '../generated/l10n.dart';

class adminRoutes extends StatefulWidget {
  const adminRoutes({super.key});

  @override
  State<adminRoutes> createState() => _adminRoutesState();
}

class _adminRoutesState extends State<adminRoutes> {

  late List<RouterController> routeControllers;

  @override
  void initState() {
    super.initState();
    routeControllers = List.generate(routesCSV.length,
            (_) =>
            RouterController(
              name: TextEditingController(),
              router: TextEditingController(),
            ));
  }

  @override
  void dispose() {
    for (final line in routeControllers) {
      line.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context0) {
    BuildContext context = Platform.isWindows ? context1 : context0;

    bool onlySql = false;
    bool sqlBd = false;

    if (sqlBd == true) {
      onlySql = true;
    }

    if (onlySql == false) {

    }
    else {
      currentRoutes = SQLRoutes;
    }


    if (routesCSV.isNotEmpty) {
      campCharge(context, routeControllers);
    }

    return Placeholder();
  }


  void campCharge(BuildContext context,
      List<RouterController> routeControllers) {
    for (int i = 0; i < routesCSV.length; i++) {
      routeControllers[i].name.text = routesCSV[i].name;
      routeControllers[i].router.text = routesCSV[i].route;
    }
  }
}