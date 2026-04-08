import 'package:flutter/material.dart';

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
            : const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(
              value: item,
              groupValue: selectedItem,
              onChanged: onChanged,
            ),
            const SizedBox(width: 4),
            Text(label(item)),
          ],
        ),
      );
    }).toList();

    return direction == Axis.vertical
        ? Column()
        : Padding(
          padding: const EdgeInsets.only(top:20),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            runSpacing: 8,
            children: [
              Text(camp),
              ...children,
            ],
          ),
        );
  }
}
