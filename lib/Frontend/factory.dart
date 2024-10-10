import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportSectors.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/createSector.dart';
import 'package:crud_factories/Backend/SQL/deleteEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/modifyFactory.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Backend/CSV//exportFactories.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<String> idscontacsDelete = [];
  List<String> sectorsString = [];

  int contactSelect = 0;
  bool edit = false;
  String id ="";
  DateTime seletedDate =DateTime.now();
  String date="";
  String sector = " ";
  String? selectedSector;
  String tmp = " ";

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
      id=factories[select].id;
      controllerName.text = factories[select].name;
      controllerHighDate.text = factories[select].highDate;
      tmp =factories[select].sector;


        for(int i = 0; i <sectors.length; i++)
        {
          if(tmp == sectors[i].id)
          {
            sector = sectors[i].name;
          }
        }

      controllerTelephone1.text = factories[select].thelephones[0];
      controllerTelephone2.text = factories[select].thelephones[1];
      controllerMail.text = factories[select].mail;
      controllerWeb.text = factories[select].web;

      var address = factories[select].address['street']!;
      var number = factories[select].address['number']!;
      var apartament = factories[select].address['apartament']!;

      String allAddress = "";

               if (apartament == "")
               {
                  allAddress = '$address, $number ';
               }
               else
               {
                   allAddress = '$address, $number - $apartament';
               }
      controllerAdrress.text = allAddress!;
      controllerCity.text = factories[select].address['city']!;
      controllerPostalCode.text = factories[select].address['postalCode']!;
      controllerProvince.text = factories[select].address['province']!;


       int idFactory = select +1;

          if(edit == false)
         {
            contacsPreEdit.clear();
            contacsCurrent.clear();
         }
              if (contacsCurrent.isEmpty && edit == false)
              {
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 200.0),
                                  child: const Text('Sector:'),
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
                                               selectedSector = sectorChoose;
                                               setState(() {
                                                 controllerSector.text =sectorChoose!;
                                               });


                                               if(sectorChoose == "Nuevo")
                                               {
                                                    String sectorcreate =  await createSector(context);
                                                    bool repeat = false;

                                                      for(int i = 0; i < sectors.length; i++)
                                                      {
                                                          if(sectorcreate == sectors[i].name)
                                                          {
                                                             repeat = true ;
                                                          }

                                                      }

                                                      if(repeat == false)
                                                      {
                                                            setState(() {
                                                              List<Sector> currentSector=[];
                                                              int idNew = sectors.length + 1;
                                                              currentSector.add(Sector(
                                                                   id: idNew.toString(),
                                                                   name: sectorcreate,
                                                                ));

                                                                sectors+=currentSector;

                                                                if(conn != null)
                                                                {
                                                                   sqlCreateSector(currentSector);
                                                                }
                                                                else
                                                                {
                                                                    csvExportatorSectors(sectors);
                                                                }

                                                        });
                                                      }
                                                      else
                                                      {
                                                         action = "Ese departamento ya existe";
                                                         error(context, action);
                                                      }

                                               }
                                               else
                                               {
                                                 for(int i = 0; i < sectors.length; i++)
                                                 {
                                                       if(sectorChoose==sectors[i].name)
                                                       {
                                                         controllerSector.text = sectors[i].id;
                                                       }
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

                                              edit = true;
                                              int idNew = empleoyes.length + 1;

                                              contacsCurrent.add(Empleoye(
                                                id: idNew.toString(),
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

                                                edit = true;
                                                Empleoye delete = contacsCurrent[contactSelect];
                                                idscontacsDelete.add(delete.id);

                                                if (contacsCurrent[contactSelect] == delete) {
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
                                          edit = false;
                                          String nameCamp = "nombre";

                                          for (int i = 0; i < factories.length; i++) {
                                            allKeys.add(factories[i].name);
                                          }

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
                                            if(campEmpty(controllerSector.text) == true)
                                            {
                                              String action ='El sector no puede ir vacio';
                                              error(context,action);
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

                                                     if(conn != null)
                                                     {

                                                          Set<Empleoye> contacsPreEdit1 = contacsPreEdit.toSet();
                                                          Set<Empleoye> contacsCurrent1 = contacsCurrent.toSet();

                                                          Set<Empleoye> empleoyesNew = contacsCurrent1.difference(contacsPreEdit1);

                                                          sqlCreateEmpleoye(empleoyesNew.toList());
                                                          empleoyes.addAll(empleoyesNew);

                                                          Set<Empleoye> empleoyesDelete = contacsPreEdit1.difference(contacsCurrent1);

                                                          List<Empleoye> empleoyesDelete1 =empleoyesDelete.toList();
                                                          sqlDeleteEmpleoye(empleoyesDelete1);

                                                            String current = "";

                                                            for(int i = 0; i < empleoyesDelete1.length; i++)
                                                            {
                                                               current = empleoyesDelete1[i].id;

                                                                   for (int x = 0; x < empleoyes.length; x++)
                                                                   {
                                                                       if(current == empleoyes[i].id)
                                                                       {
                                                                           empleoyes.removeAt(x);
                                                                       }
                                                                   }
                                                            }
                                                          edit =true;

                                                     }
                                                    if(select == - 1)
                                                    {
                                                      int idNew = factories.length+1;
                                                      current.add(Factory(
                                                          id:idNew.toString(),
                                                          name: controllerName.text,
                                                          highDate: controllerHighDate.text,
                                                          sector: controllerSector.text,
                                                          thelephones:[controllerTelephone1.text,controllerTelephone2.text],
                                                          mail: controllerMail.text,
                                                          web: controllerWeb.text,
                                                          address: {
                                                            'street':adrress1[0],
                                                            'number':num[1],
                                                            'apartament':apartament,
                                                            'city' : controllerCity.text,
                                                            'postalCode' : controllerPostalCode.text ,
                                                            'province' : controllerProvince.text,
                                                          },
                                                      ));
                                                      action ='La empresa se ha dado de alta correctamente';
                                                      confirm(context,action);
                                                    }
                                                    else
                                                    {

                                                      factories[select].name = controllerName.text;
                                                      factories[select].highDate = controllerHighDate.text;
                                                      factories[select].sector = controllerSector.text;
                                                      factories[select].thelephones= [controllerTelephone1.text,controllerTelephone2.text];
                                                      factories[select].mail = controllerMail.text;
                                                      factories[select].web= controllerWeb.text;
                                                      factories[select].address['street'] = adrress1[0];
                                                      factories[select].address['number'] = num[1];
                                                      factories[select].address['apartament'] = apartament;
                                                      factories[select].address['city'] = controllerCity.text;
                                                      factories[select].address['postalCode'] = controllerPostalCode.text ;

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

                                                      empleoyes = [
                                                        ...{...empleoyes, ...contacsCurrent}
                                                      ];

                                                      String idCurrent= "";
                                                      for(int i = 0; i <idscontacsDelete.length; i++)
                                                      {
                                                        idCurrent = idscontacsDelete[i];

                                                        for(int y = 0; y< empleoyes.length;y++)
                                                        {
                                                          if(idCurrent==empleoyes[y].id)
                                                          {
                                                            empleoyes.removeAt(y);
                                                          }
                                                        }

                                                      }

                                                      csvExportatorEmpleoyes(empleoyes);
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
                                          contacsCurrent.clear();
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



