import 'dart:io';

import 'package:crud_factories/Backend/providers/Conection_provider.dart';
import 'package:crud_factories/Platform/appDesktop.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'Alertdialogs/closeApp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crud_factories/generated/l10n.dart';

import 'Backend/Global/routes.dart';
import 'Platform/appAndroid.dart';




final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

        WidgetsFlutterBinding.ensureInitialized();

      if(!kIsWeb)
        await windowManager.ensureInitialized();

        runApp(
            MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => ConectionProvider()
              )
            ],
            child: MyApp())
           );
}
class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    if (kIsWeb) {
      return FluentApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
            builder: (context) {
              MyWindowListener.context = context;
              _initializeWindow(context);

              return appDesktop();
            }
        ),
      );
    }
    if (Platform.isWindows) {
      return FluentApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
          builder: (context) {
            MyWindowListener.context = context;
            _initializeWindow(context);
            return appDesktop();
          },
        ),
      );
    }
      return MaterialApp(
        onGenerateTitle: (context) => S.of(context).appTitle,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: '/',
        routes: getAppRoutes(),
        home: appAndroid(),
      );
  }

  void _initializeWindow(BuildContext context){
    if (kIsWeb) return;
    WindowOptions windowOptions = WindowOptions(
      size: const Size(800,600),
      center: true,
      title: S.of(context).appTitle,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async{

      await windowManager.show();
      await windowManager.focus();
      await windowManager.setPreventClose(true);

    });

    windowManager.addListener(MyWindowListener());
  }
}



class MyWindowListener with WindowListener {

  static late BuildContext context;

  @override
  void onWindowClose() async {
     closeAlert(context);
  }
}
