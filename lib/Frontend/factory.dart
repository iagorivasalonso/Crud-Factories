import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/deleteEmpleoyes.dart';
import 'package:crud_factories/Backend/SQL/modifyFactory.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV//exportFactories.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';




class newFactory extends StatefulWidget {

  int select;
  newFactory(this.select);

  @override
  State<newFactory> createState() => _newFactoryState();
}

class _newFactoryState extends State<newFactory> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  late TextEditingController controllerName = new TextEditingController();
  late TextEditingController controllerHighDate = TextEditingController();
  late TextEditingController controllerSector = TextEditingController();
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

  List<Empleoye> contacsCurrent = [];
  List<Empleoye> contacsPreEdit = [];
  List<String> idsDelete = [];
  List<String> sectorsString = [];

  DateTime seletedDate =DateTime.now();

  int contactSelect = 0;
  String id ="";
  String date="";
  String sector = " ";
  String? selectedSector;
  String tmp = " ";
  String allAddress = "";
  @override
  Widget build(BuildContext context) {

    int select= widget.select;

    sectorsString.clear();

    sectorsString.add("Nuevo");

    for(int i = 0; i < sectors.length; i++)
    {
        sectorsString.add(sectors[i].name);
    }

    void campCharge () {

      if(saveChanges == false)
      {
            id = allFactories[select].id;
            controllerName.text = allFactories[select].name;
            controllerHighDate.text = allFactories[select].highDate;
            tmp = allFactories[select].sector;
            controllerSector.text = tmp;

            for(int i = 0; i <sectors.length; i++)
            {
              if(tmp == sectors[i].id)
              {
                sector = sectors[i].name;
              }
            }

            controllerTelephone1.text = allFactories[select].thelephones[0];
            controllerTelephone2.text = allFactories[select].thelephones[1];
            controllerMail.text = allFactories[select].mail;
            controllerWeb.text = allFactories[select].web;

            var address = allFactories[select].address['street']!;
            var number = allFactories[select].address['number']!;
            var apartament = allFactories[select].address['apartament']!;



            if (apartament == "")
            {
              allAddress = '$address,$number';
            }
            else
            {
              allAddress = '$address,$number-$apartament';
            }
            controllerAdrress.text = allAddress!;
            controllerCity.text = allFactories[select].address['city']!;
            controllerPostalCode.text = allFactories[select].address['postalCode']!;
            controllerProvince.text = allFactories[select].address['province']!;


            int idFactory = select +1;


            contacsPreEdit.clear();
            contacsCurrent.clear();



            for (int i = 0; i < empleoyes.length; i++)
            {
              if(empleoyes[i].idFactory == idFactory.toString())
              {
                contacsPreEdit.add(empleoyes[i]);
                contacsCurrent.add(empleoyes[i]);
              }
            }

      }

    }
    String action = "actualizar";
    String action2 = "";
    String title = "";

    if (select == -1) {
      title = "Nueva ";
      action = "Crear";
      action2 = "Borrar";
      sector = "Seleccionar";
    }
    else {
      title = "Editar ";
        campCharge();

      action = "Actualizar";
      action2 = "Deshacer";
   }

    final ShowPlatformDatePicker platformDatePicker = ShowPlatformDatePicker(buildContext: context);

    return Scaffold(
      body: AdaptiveScrollbar(
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
                                    onChanged: (s) {

                                        if(saveChanges == false)
                                        {
                                          if(select != -1)
                                          {
                                            if(controllerName.text == allFactories[select].name)
                                            {
                                              saveChanges = false;
                                            }
                                            else
                                            {
                                              saveChanges = true;
                                            }
                                          }
                                          else
                                          {
                                              if(controllerName.text.isEmpty)
                                              {
                                                   saveChanges = false;
                                              }
                                              else
                                              {
                                                  saveChanges = true;
                                              }
                                          }

                                        }

                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerHighDate.text == allFactories[select].highDate)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
                                    onTap: () async {
                                      if(select == -1)
                                      {
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

                                      }

                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 200.0),
                                  child: Text('Sector:'),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.00),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        hint:  Text(sector),
                                        items: sectorsString.map((String itemSector) => DropdownMenuItem<String>(
                                          value:  itemSector,
                                          child: Text(itemSector),
                                        )).toList(),
                                        value: selectedSector,
                                        onChanged: (String? sectorChoose) async {

                                                if(saveChanges == false && select != -1)
                                                {
                                                    saveChanges = true;
                                                }

                                               selectedSector = sectorChoose;
                                               setState(() {
                                                 controllerSector.text =sectorChoose!;
                                               });

                                               if(sectorChoose == "Nuevo")
                                               {

                                                     String modif = "nuevo";
                                                     bool create = await createSector(context,modif);

                                                       if(create == true)
                                                       {
                                                           setState((){
                                                               String action = 'El sector se ha creado correctamente';
                                                               confirm(context, action);
                                                           });
                                                       }
                                               }
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          height: 50,
                                          width: 200,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 180,
                                          scrollbarTheme: ScrollbarThemeData(
                                            thickness: MaterialStateProperty.all(6),
                                          ),
                                        ),
                                      ),
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerTelephone1.text == allFactories[select].thelephones[0])
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerTelephone2.text == allFactories[select].thelephones[1])
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerMail.text == allFactories[select].mail)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerWeb.text == allFactories[select].web)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerAdrress.text == allAddress)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerCity.text == allFactories[select].address['city']!)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerPostalCode.text == allFactories[select].address['postalCode']!)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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
                                    onChanged: (s) {
                                      if(saveChanges == false && select != -1)
                                      {
                                        if(controllerProvince.text == allFactories[select].address['province']!)
                                        {
                                          saveChanges = false;
                                        }
                                        else
                                        {
                                          saveChanges = true;
                                        }
                                      }
                                    },
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

                                              saveChanges = true;
                                              String idNew = "";

                                              if(empleoyes.isNotEmpty)
                                              {
                                                String idLast = empleoyes[empleoyes.length-1].id;
                                                idNew = createId(idLast);
                                              }
                                              else
                                              {
                                                idNew ="1";
                                              }

                                              contacsCurrent.add(Empleoye(
                                                id: idNew,
                                                name: controllerEmpleoyeeNew.text,
                                                idFactory: id
                                              ));

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
                                                saveChanges = true;

                                                Empleoye delete = contacsCurrent[contactSelect];
                                                idsDelete.add(delete.id);

                                                    if (contacsCurrent[contactSelect] == delete)
                                                    {
                                                        contacsCurrent.removeAt(contactSelect);
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
                                        itemCount: contacsCurrent.length,
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
                                                child: Text(contacsCurrent[index].name),
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
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action,
                                        style: TextStyle(color: Colors.white)
                                    ),
                                    onPressed: () async {


                                        bool errorExp = await csvExportatorFactories(allFactories);

                                        if(errorExp == false)
                                        {
                                          String action = 'Las empresas se han guardado correctamente';
                                          await confirm(context, action);
                                        }
                                        else
                                        {
                                          String action = 'No existe archivo de empresas';
                                          error(context, action);
                                        }
                                    },
                                  ),
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action2,
                                        style: TextStyle(color: Colors.white)
                                    ),
                                    onPressed: () {
                                      if(select == -1)
                                      {
                                        controllerName.clear();
                                        controllerHighDate.clear();
                                        controllerTelephone1.clear();
                                        controllerTelephone2.clear();
                                        controllerMail.clear();
                                        controllerWeb.clear();
                                        controllerAdrress.clear();
                                        controllerCity.clear();
                                        controllerPostalCode.clear();
                                        controllerProvince.clear();
                                        controllerContacs.clear();
                                        controllerEmpleoyee.clear();
                                        setState(() {
                                          contacsCurrent.clear();
                                        });
                                        controllerEmpleoyeeNew.clear();
                                      }
                                      else
                                      {
                                        campCharge();
                                      }
                                      saveChanges = false;
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
      ),
    );
  }
}



