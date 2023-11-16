import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class newImport extends StatefulWidget {
  const newImport({Key? key}) : super(key: key);

  @override
  State<newImport> createState() => _newImportState();
}

class _newImportState extends State<newImport> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  get selectedValue => null;

  @override
  Widget build(BuildContext context) {
    List<String> typeList = ['uno', 'dos'];

    return AdaptiveScrollbar(
      controller: verticalScroll,
      width: widthBar,
      child: AdaptiveScrollbar(
        controller: horizontalScroll,
        width: widthBar,
        position: ScrollbarPosition.bottom,
        underSpacing: EdgeInsets.only(bottom: 8),
        child: SingleChildScrollView(
          controller: verticalScroll,
          scrollDirection: Axis.vertical,
          child: Container(
            width: 2000,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 429,
                width: 736,
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 30.0,top: 30.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text('Importar datos: ',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15.00),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Importar datos en formato CSV.'),
                                ],
                              ),
                            ],
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            children: [
                              Text("Tipo de dato: "),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: const Expanded(
                                          child: Text('Select Item',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        items: typeList
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child:Text(item,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged:
                                            (String?  value) {
                                          setState(()
                                          {});
                                        },
                                        buttonStyleData: const  ButtonStyleData(
                                          height: 50,
                                          width: 160,
                                          padding: EdgeInsets.only(left:14, right: 14),
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:50.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Ruta: '),
                              const SizedBox(
                                width: 400,
                                height: 40,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: ElevatedButton(
                                  child: const Text('Examinar'),
                                  onPressed: (){},
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:10.0, bottom: 30.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 45.0),
                                child: Text('El archivo a importar debe estar en formato csv ',
                                  style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:34.0,left: 400),
                          child: Container(
                            width: 250,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: const Text('Importar datos'),
                                  onPressed: () {},
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
}