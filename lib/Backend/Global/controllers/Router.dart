

import 'package:fluent_ui/fluent_ui.dart';

class RouterController {

  final TextEditingController name;
  final TextEditingController router;


  RouterController({
    required this.name,
    required this.router,
  });

  void dispose() {
    name.dispose();
    router.dispose();
  }
}
