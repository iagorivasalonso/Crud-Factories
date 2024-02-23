import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/campRepeat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import '../Alertdialogs/confirm.dart';
import '../Backend/exportFactories.dart';
import '../Functions/avoidRepeatCamp.dart';
import '../Objects/Factory.dart';


class newFactory extends StatefulWidget {

  List<Factory> factories;
  int select;


  newFactory(this.factories,this.select);

  @override
  State<newFactory> createState() => _newFactoryState();
}

class _newFactoryState extends State<newFactory> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  int select =-1;

  double widthBar = 10.0;
  TextEditingController controllerName = new TextEditingController();

  late TextEditingController controllerHighDate = TextEditingController();
  late TextEditingController controllerTelephone1 = TextEditingController();
  late TextEditingController controllerTelephone2 = TextEditingController();
  late TextEditingController controllerMail = TextEditingController();
  late TextEditingController controllerWeb = TextEditingController();
  late TextEditingController controllerAdrress = TextEditingController();
  late TextEditingController controllerCity = TextEditingController();
  late TextEditingController controllerPostalCode = TextEditingController();
  late TextEditingController controllerProvince = TextEditingController();
  List<TextEditingController> controllerContacs = [];
  late TextEditingController controllerEmpleoyee = TextEditingController();
  late TextEditingController controllerEmpleoyeeNew = TextEditingController();

  List<String> contacs = [];
  int contactSelect = 0;
  bool edit = false;
  String id ="";
  DateTime seletedDate =DateTime.now();
  String date="";

  @override
  Widget build(BuildContext context) {
    List<Factory> factories = widget.factories;

    select = widget.select;


    String action = "actualizar";
    String title = "";



    if (select == -1) {
      title = "Nueva ";
      action = "Crear";

    }
    else {
      title = "Editar ";


        id=factories[select].id;
        controllerName.text = factories[select].name;
        controllerHighDate.text = factories[select].highDate;
        controllerTelephone1.text = factories[select].thelephones[0];
        controllerTelephone2.text = factories[select].thelephones[1];
        controllerMail.text = factories[select].mail;
        controllerWeb.text = factories[select].web;

        var address = factories[select].address['street']!;
        var number = factories[select].address['number']!;
        var apartament = factories[select].address['apartament']!;

        String allAddress = "";

        if (apartament == "") {
          allAddress = '$address, $number ';
        }
        else {
          allAddress = '$address, $number - $apartament';
        }

        controllerAdrress.text = allAddress!;
        controllerCity.text = factories[select].address['city']!;
        controllerPostalCode.text = factories[select].address['postalCode']!;
        controllerProvince.text = factories[select].address['province']!;
        contacs = widget.factories[select].contacts;

        if (contacs.isEmpty) {
          for (int i = 0; i < factories[select].contacts.length; i++) {
            contacs.add(factories[select].contacts[i]);
          }
        }



     action = "Actualizar";

   }

    final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context);

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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30.0, bottom: 30.0),
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
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Text('Fecha de alta: '),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: TextField(
                                  controller: controllerHighDate,
                                  decoration:  InputDecoration(
                                    border: const OutlineInputBorder(),
                                    icon: select == -1
                                        ? const Icon(Icons.calendar_today)
                                        : null,
                                  ),
                                  onTap: () async {
                                    DateTime? dateSelected = await  platformDatePicker.showPlatformDatePicker(
                                      context,
                                      seletedDate,
                                      DateTime(DateTime.now().year - 10),
                                      DateTime(DateTime.now().year + 1),
                                    );
                                    setState(() {
                                      date =DateFormat('dd-MM-yyyy').format(dateSelected!);
                                      controllerHighDate.text = date;

                                    });

                                  },

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
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 20.0),
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
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 20.0),
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
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 20.0),
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
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 20.0),
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
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 30.0, left: 20.0),
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
                          padding: const EdgeInsets.only(
                              top: 24.0, left: 80.0, bottom: 40.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 160,
                                child: SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: TextField(
                                    controller: controllerEmpleoyeeNew,
                                    decoration: const InputDecoration(
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
                                        child: const Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            contacs.add(controllerEmpleoyeeNew.text);
                                            controllerEmpleoyeeNew.text = "";
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0),
                                        child: ElevatedButton(
                                          child: const Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              var delete = contacs[contactSelect];
                                              if (contacs[contactSelect] == delete) {
                                                contacs.removeAt(contactSelect);
                                                String action ='El empleado se ha quitado correctamente';
                                                confirm(context,action);
                                              }
                                              });
                                            },

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
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        border: Border.all(
                                          color: Colors.black38,
                                          width: 1.0,
                                        )
                                    ),
                                    width: 250,
                                    height: 170,
                                    child: ListView.builder(
                                      itemCount: contacs.length,
                                      itemBuilder: (BuildContext context,
                                          index) {
                                        return GestureDetector(
                                          child: Container(
                                            color:  index== contactSelect
                                                ? Colors.blue
                                                : Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3.0, left: 10.0),
                                              child: Text(contacs[index]),
                                            ),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              contactSelect = index;

                                            });


                                          },
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
                                      setState(() {
                                        bool repeat=false;
                                        List<String> campSearch=[];

                                        for(int i = 0; i <factories.length; i++)
                                        {
                                            campSearch.add(factories[i].name);
                                        }
                                        bool repeat1=avoidRepeteatCamp(context, repeat,campSearch, controllerName, select);
                                        print(repeat1);

                                        if(repeat1 == true)
                                        {
                                          action ='El usuario ya se encuentra en la base de datos';
                                          campRepeat(context,action);
                                        }
                                        else
                                        {

                                             List<String> adrress1=controllerAdrress.text.split(",");
                                             List<String> adrress2=controllerAdrress.text.split("-");
                                             

                                             if(select ==- 1)
                                             {

                                               factories.add(Factory(
                                                     id:factories.length.toString(),
                                                     name: controllerName.text,
                                                     highDate: controllerHighDate.text,
                                                     thelephones:[controllerTelephone1.text,controllerTelephone2.text],
                                                     mail: controllerMail.text,
                                                     web: controllerWeb.text,
                                                     contacts:contacs,
                                                     address: {
                                                          'street':adrress1[0],
                                                          'number':adrress2[0],
                                                          'apartament': adrress2[1],
                                                          'city' : controllerCity.text,
                                                          'postalCode' : controllerPostalCode.text ,
                                                          'province' : controllerProvince.text,
                                                         }
                                                      ));
                                                         action ='La empresa se ha dado de alta correctamente';
                                                         confirm(context,action);
                                             }
                                             else
                                             {
                                                  List<String>num=adrress2[0].split(",");

                                                 factories[select].name = controllerName.text;
                                                 factories[select].highDate = controllerHighDate.text;
                                                 factories[select].thelephones= [controllerTelephone1.text,controllerTelephone2.text];
                                                 factories[select].mail = controllerMail.text;
                                                 factories[select].web= controllerWeb.text;
                                                 factories[select].address['street']=adrress1[0];
                                                 factories[select].address['number']=num[1];
                                                 factories[select].address['apartament']=adrress2[1];
                                                 factories[select].address['city']=controllerCity.text;
                                                 factories[select].address['postalCode']= controllerPostalCode.text ;
                                                 factories[select].address['province']= controllerProvince.text;

                                                  action ='El usuario se ha modificado correctamente';
                                                  confirm(context,action);

                                             }
                                             csvExportator(factories,select);
                                        }


                                      });
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('Eliminar'),
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
