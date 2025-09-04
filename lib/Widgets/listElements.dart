import 'package:fluent_ui/fluent_ui.dart';

import '../Objects/Empleoye.dart';

Padding listElements({

  required List<Empleoye> contacsCurrent,
  required int contactsSelect,
  required int contactSelect}){
  return  Padding(
    padding: const EdgeInsets.only(left: 35.0, top: 20.0, bottom: 30.0, right: 90.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      width: 250,
      height: 170,
      child: ListView.builder(
        itemCount: contacsCurrent.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                contactSelect = index;
              });
            },
            child: Container(
              color: index == contactSelect ? Colors.blue : Colors.white,
              child: Padding(padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                child: Text(contacsCurrent[index].name,
                  style: TextStyle(
                    color: index == contactSelect ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

void setState(Null Function() param0) {
}