import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:flutter/material.dart';



class ContactList extends StatelessWidget {
  final List<Empleoyee> contacsCurrent;
  final Empleoyee? selected;
  final Function(Empleoyee) onSelect;

  const ContactList({
    required this.contacsCurrent,
    required this.onSelect,
    this.selected,
  });

  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: contacsCurrent.length,
      itemBuilder: (context, index) {
        final employee = contacsCurrent[index];
        final isSelected = selected?.id == employee.id;

        return GestureDetector(
          onTap: () => onSelect(employee),
          child: Container(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            color: isSelected
                ? Colors.blue.withOpacity(0.2)
                : Colors.transparent,
            child: Text(
              employee.name,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}