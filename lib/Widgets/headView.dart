import 'package:fluent_ui/fluent_ui.dart';

Row headView({
  required String title,
}) {
  return Row(
    children: [
      Text('$title',
        style: const TextStyle(
            fontWeight: FontWeight.bold),),
    ],
  );
}
