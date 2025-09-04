import 'package:fluent_ui/fluent_ui.dart';

class layoutVariant extends StatelessWidget {

  final List<Widget> items;
  final CrossAxisAlignment crossAxisAlignment;

  const layoutVariant({super.key, required this.items, this.crossAxisAlignment = CrossAxisAlignment.start, });

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.start,
      children: items,
    );
  }
}