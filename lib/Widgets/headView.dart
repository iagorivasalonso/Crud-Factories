import 'package:fluent_ui/fluent_ui.dart';

Row headView({
  required String title,
}) {
  return Row(
    children: [
      Expanded(child: Text(title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,)
      ),
    ],
  );
}
