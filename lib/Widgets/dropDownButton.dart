import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class GenericDropdown<T> extends StatelessWidget {
  final String camp;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final String Function(T) itemLabel;

  const GenericDropdown({
    Key? key,
    required this.camp,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.hint,
    required this.itemLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
            child: Text(camp)
        ),
        const SizedBox(width: 15),
        Expanded(
          flex: 2,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              isExpanded: true,
              hint: Text(hint),
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabel(item)),
                ),
              ).toList(),
              value: selectedItem,
              onChanged: onChanged,
              buttonStyleData: const ButtonStyleData(
                height: 50,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
