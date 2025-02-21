import 'package:crud_factories/Frontend/app.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'Alertdialogs/closeApp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:crud_factories/generated/l10n.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    return FluentApp(
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

          String appTitle = S.of(context).cancel;

           _initializeWindow(appTitle);

          return App();
        }
      ),
    );
  }

  void _initializeWindow(String title){

    WindowOptions windowOptions = WindowOptions(
      size: const Size(800,600),
      center: true,
      title: title
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
