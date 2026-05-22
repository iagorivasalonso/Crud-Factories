
import 'package:crud_factories/Backend/Providers/App_provaider.dart';
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class DependencyInjection {

   static List<SingleChildWidget> providers = [

     // =========================
     // APP
     // =========================

     ChangeNotifierProvider(
       create: (_) => AppProvider(),
     ),

     ChangeNotifierProvider(
       create: (_) => NavigationProvider(),
     ),

     ChangeNotifierProvider(
       create: (_) => EditStateProvider(),
     ),

   ];
}