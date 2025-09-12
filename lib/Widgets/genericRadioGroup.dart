import 'package:fluent_ui/fluent_ui.dart';

class GenericRadioGroup<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String camp;
  final String Function(T item) label;
  final ValueChanged<T?> onChanged;
  final Axis direction;

  const GenericRadioGroup({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.label,
    required this.onChanged,
    this.direction = Axis.vertical,
    required this.camp,
  });

  @override
  Widget build(BuildContext context) {
    final children = items.map((item) {
      return Padding(
        padding: direction == Axis.vertical
            ? const EdgeInsets.only(bottom: 8.0)
            : const EdgeInsets.only(right: 50.0),
        child: RadioButton(
          checked: selectedItem == item,
          onChanged: (bool? value) {
            if (value == true) onChanged(item);
          },
          content: Text(label(item)),
        ),
      );
    }).toList();

    return direction == Axis.vertical
        ? Column()
        : Padding(
          padding: const EdgeInsets.only(top:20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  camp,
                ),
              ),

          ...children,
                ],
              ),
        );
  }
}
