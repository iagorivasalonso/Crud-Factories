import 'package:fluent_ui/fluent_ui.dart';

import '../Objects/Empleoye.dart';

class ContactList extends StatefulWidget {
  final List<Empleoye> contacsCurrent;

  const ContactList({super.key, required this.contacsCurrent});

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  int contactSelect = -1; // Inicialmente ninguno seleccionado

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, top: 20.0, bottom: 30.0, right: 90.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color:const Color(0xFFB0B0B0),
            width: 1.0,
          ),
        ),
        width: 340,
        height: 170,
        child: ListView.builder(
          itemCount: widget.contacsCurrent.length,
          itemBuilder: (BuildContext context, int index) {
            final employee = widget.contacsCurrent[index];
            final isSelected = index == contactSelect;
            return GestureDetector(
              onTap: () {
                setState(() {
                  contactSelect = index;
                });
              },
              child: Container(
                color: isSelected ? Colors.blue : Colors.white,
                padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                child: Text(
                  employee.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
