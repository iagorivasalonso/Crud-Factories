import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class GenericDropdown<T> extends StatelessWidget {

  final String camp;
  final String? opDefault;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final String Function(T) itemLabel;

  const GenericDropdown({
    Key? key,
    required this.camp,
    this.opDefault,
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
              items:  [
               if (opDefault != null && opDefault!.isNotEmpty)
                  DropdownMenuItem<T>(
                      value: null,
                      child: Text(opDefault!),
                  ),
                      ...items.map(
                      (item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(itemLabel(item)),
                      ),
                  ),
              ],
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
