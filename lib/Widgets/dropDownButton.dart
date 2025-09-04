
import 'package:dropdown_button2/dropdown_button2.dart' show ButtonStyleData, DropdownButton2, DropdownStyleData;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show DropdownButtonHideUnderline, DropdownMenuItem, MaterialStateProperty;
class GenericDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;
  final double? height;
  final double? width;

  const GenericDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.hintText,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: Text(hintText),
          value: selectedItem,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabelBuilder(item)),
            );
          }).toList(),
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: height ?? 40,
            width: width ?? 200,
            padding: const EdgeInsets.symmetric(horizontal: 14),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: (width ?? 200) - 20,
          ),
        ),
      ),
    );
  }
}
