import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/modifyFactory.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV//exportFactories.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import '../Alertdialogs/confirm.dart';



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

    int select= widget.select;

    void campCharge () {
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
      contacs = factories[select].contacts;

      if (contacs.isEmpty) {
        for (int i = 0; i < factories[select].contacts.length; i++) {
          contacs.add(factories[select].contacts[i]);
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
                                  MaterialButton(
                                    color: Colors.lightBlue,
                                    child: Text(action,
                                        style: TextStyle(color: Colors.white)
                                    ),
                                    onPressed: () {
                                        setState(() {
                                          List <Factory> current=[];
                                          List <String> allKeys = [];
                                          String nameCamp = "nombre";
                                          for (int i = 0; i < factories.length; i++)
                                            allKeys.add(factories[i].name);

                                          String campOld = " ";

                                          if(select != -1)
                                          {
                                            campOld = factories[select].name;
                                          }

                                          if(primaryKeyCorrect(controllerName.text,nameCamp,allKeys,campOld,context) ==true)
                                          {
                                            final telephone1 = controllerTelephone1.text.replaceAll(" ", "");
                                            final telephone2 = controllerTelephone2.text.replaceAll(" ", "");

                                            if(dateCorrect(controllerHighDate.text) == false)
                                            {
                                              String action ='El fomato de la fecha debe de ser:';
                                              String format ='DD-MM-AAAA';
                                              error(context,action,format);
                                            }
                                            else if(telephoneCorrect(telephone1,context) == true)
                                            {
                                              if(telephone1.length != 9)
                                              {
                                                action ='El telefono debe de tener 9 digitos';
                                                error(context,action);

                                              }
                                              else if(telephoneCorrect(telephone2,context) == true)
                                              {
                                                if(telephone2.length != 9)
                                                {
                                                  action ='El telefono debe de tener 9 digitos';
                                                  error(context,action);
                                                }
                                                else if(mailCorrect(controllerMail.text) != true)
                                                {
                                                  action ='No es un correo electronico valido';
                                                  error(context,action);
                                                }
                                                else if(webCorrect(controllerWeb.text) != true)
                                                {
                                                  action ='No es una dirreccion web';
                                                  error(context,action);
                                                }
                                                else if(adrressCorrect(controllerAdrress.text) != true)
                                                {
                                                  String action ='El fomato de la direccion debe de ser:';
                                                  String format =' calle, numero';
                                                  error(context,action,format);
                                                }
                                                else if(postalCodeCorrect(controllerPostalCode.text,context) == true)
                                                {
                                                  if(controllerPostalCode.text.length != 5)
                                                  {
                                                    action ='El codigo postal debe de tener 5 digitos';
                                                    error(context,action);
                                                  }
                                                  else{

                                                    List<String> adrress1 = controllerAdrress.text.split(",");
                                                    List<String> adrress2 = controllerAdrress.text.split("-");
                                                    String apartament='';

                                                    if(controllerAdrress.text.contains("-"))
                                                    {
                                                      apartament = adrress2[1];
                                                    }
                                                    else
                                                    {
                                                      apartament='';
                                                    }
                                                    List<String> num = adrress2[0].split(",");

                                                    if(select == - 1)
                                                    {
                                                      int idNew = factories.length+1;
                                                      current.add(Factory(
                                                          id:idNew.toString(),
                                                          name: controllerName.text,
                                                          highDate: controllerHighDate.text,
                                                          thelephones:[controllerTelephone1.text,controllerTelephone2.text],
                                                          mail: controllerMail.text,
                                                          web: controllerWeb.text,
                                                          contacts:contacs,
                                                          address: {
                                                            'street':adrress1[0],
                                                            'number':num[1],
                                                            'apartament':apartament,
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

                                                      factories[select].name = controllerName.text;
                                                      factories[select].highDate = controllerHighDate.text;
                                                      factories[select].thelephones= [controllerTelephone1.text,controllerTelephone2.text];
                                                      factories[select].mail = controllerMail.text;
                                                      factories[select].web= controllerWeb.text;
                                                      factories[select].address['street'] = adrress1[0];
                                                      factories[select].address['number'] = num[1];
                                                      factories[select].address['apartament'] = apartament;
                                                      factories[select].address['city'] = controllerCity.text;
                                                      factories[select].address['postalCode'] = controllerPostalCode.text ;
                                                      factories[select].address['province'] = controllerProvince.text;
                                                      factories[select].contacts = contacs;
                                                      action ='El usuario se ha modificado correctamente';
                                                      confirm(context,action);

                                                    }


                                                    if(conn != null)
                                                    {
                                                         if(select == -1)
                                                         {
                                                           sqlCeateFactory(current);
                                                         }
                                                         else
                                                         {

                                                           current.add(factories[select]);
                                                           sqlModifyFActory(current);
                                                         }
                                                    }
                                                    else
                                                    {
                                                      factories = factories + current;
                                                      csvExportatorFactories(factories,select);
                                                    }

                                                  }
                                                }
                                              }
                                            }
                                          }


                                        });
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
                                          contacs.clear();
                                        });
                                        controllerEmpleoyeeNew.clear();
                                      }
                                      else
                                      {
                                        campCharge();
                                      }
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



