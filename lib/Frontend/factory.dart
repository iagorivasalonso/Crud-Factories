import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

import '../Objects/Factory.dart';


class newFactory extends StatefulWidget {

  List<Factory> factories;
  int select;

  newFactory(this.factories,this.select,);

  @override
  State<newFactory> createState() => _newFactoryState();
}

class _newFactoryState extends State<newFactory> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerName;
  late TextEditingController controllerHighDate;
  late TextEditingController controllerTelephone1;
  late TextEditingController controllerTelephone2;
  late TextEditingController controllerMail;
  late TextEditingController controllerWeb;
  late TextEditingController controllerAdrress;
  late TextEditingController controllerCity;
  late TextEditingController controllerPostalCode;
  late TextEditingController controllerProvince;
  List<TextEditingController> controllerContacs=[];
  late TextEditingController controllerEmpleoyee;

  @override
  Widget build(BuildContext context) {

    controllerName =  TextEditingController();
    controllerHighDate = TextEditingController();
    controllerTelephone1= TextEditingController();
    controllerTelephone2 = TextEditingController();
    controllerMail = TextEditingController();
    controllerWeb = TextEditingController();
    controllerAdrress = TextEditingController();
    controllerCity = TextEditingController();
    controllerPostalCode = TextEditingController();
    controllerProvince = TextEditingController();
    controllerEmpleoyee = TextEditingController();


    List<Factory> factories = widget.factories;
    int select = widget.select;

    String action = "";
    String title = "";


    if(select == -1)
    {
      title = "Nueva ";
      action = "Crear";
    }
    else
    {
      title = "Editar ";

      controllerName.text = factories[select].name;
      controllerHighDate.text = factories[select].highDate;
      controllerTelephone1.text = factories[select].thelephones[0];
      controllerTelephone2.text = factories[select].thelephones[1];
      controllerMail.text = factories[select].mail;
      controllerWeb.text = factories[select].web;

              var address = factories[select].address['street']!;
              var number = factories[select].address['number']!;
              var apartament =factories[select].address['apartament']!;

              String allAddress = "";

              if(apartament == "")
              {
                allAddress ='$address, $number ';
              }
              else
              {
                allAddress ='$address, $number - $apartament';
              }

      controllerAdrress.text = allAddress!;
      controllerCity.text = factories[select].address['city']!;
      controllerPostalCode.text = factories[select].address['postalCode']!;
      controllerProvince.text = factories[select].address['province']!;

      controllerContacs.clear();
      for (int i = 0; i < factories[select].contacts.length; i++)
      {


        controllerEmpleoyee.text=factories[select].contacts[i];
        controllerContacs.add(controllerEmpleoyee);

      }
      print(controllerContacs.length);

      action = "Actualizar";
    }

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
                height: 1005,
                width: 856,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('$title Empresa: ',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Nombre: '),
                              SizedBox(
                                width: 450,
                                height: 40,
                                child: TextField(
                                  controller: controllerName,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                       Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 30.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Fecha de alta: '),
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: TextField(
                                  controller: controllerHighDate,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Contacto: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                         Padding(
                           padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              const Text('Telefono 1: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerTelephone1,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 85.0),
                                child: Text('Telefono 2: '),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerTelephone2,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              Text('Email: '),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: TextField(
                                  controller: controllerMail,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                             const Padding(
                                padding: EdgeInsets.only(left: 70.0),
                                child: Text('Pagina web: '),
                              ),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: TextField(
                                  controller: controllerWeb,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              const Text('Dirección: '),
                              SizedBox(
                                width: 600,
                                height: 40,
                                child: TextField(
                                  controller: controllerAdrress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              const Text('Ciudad: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerCity,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 85.0),
                                child: Text('Código postal: '),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerPostalCode,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                          child: Row(
                            children: [
                              const Text('Provincia: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerProvince,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              'Contactos en la empresa: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 80.0, bottom: 40.0),
                          child: Row(
                            children: [
                            const SizedBox(
                               height: 160,
                               child: SizedBox(
                                 width: 250,
                                 height: 40,
                                 child: TextField(
                                   decoration: InputDecoration(
                                     border: OutlineInputBorder(),
                                   ),
                                 ),
                               ),
                             ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0),
                                child: SizedBox(
                                  height: 160,
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        child: Text('>>'),
                                        onPressed: () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12.0),
                                        child: ElevatedButton(
                                          child: const Text('<<'),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             Align(
                               alignment: Alignment.topLeft,
                               child: Container(
                                   decoration: BoxDecoration(
                                       borderRadius: const BorderRadius.all( Radius.circular(5),
                                       ),
                                       border: Border.all(
                                           color: Colors.black38,
                                           width: 1.0,
                                       )
                                   ),
                                  width: 250,
                                  height: 170,
                                  child: ListView.builder(
                                      itemCount: controllerContacs.length,
                                      itemBuilder: (BuildContext context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left:8.0, top: 4.0),
                                          child: Text(controllerContacs[index].text),
                                        );
                                      },

                                  )
                                ),
                             ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 550.0),
                          child: Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: Text(action),
                                  onPressed: () {

                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {

                                  },
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
