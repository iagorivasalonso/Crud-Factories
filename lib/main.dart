import 'package:fluent_ui/fluent_ui.dart';

import 'Screens/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Materialapp',
      home: NavigationScreen(),
    );
  }
}
