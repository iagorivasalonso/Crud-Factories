import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
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
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';




class newFactory extends StatefulWidget {

  BuildContext context;
  int select;

  newFactory(this.context, this.select);

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

    int select = widget.select;
    BuildContext context = widget.context;
    sectorsString.clear();

    sectorsString.add(S.of(context).newMale);

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
    String action = S.of(context).update;
    String action2 = "";
    String title = "";

    if (select == -1) {
      title = S.of(context).newFemale;
      action = S.of(context).create;
      action2 = S.of(context).delete;
      sector = S.of(context).select;
    }
    else {
      title = S.of(context).edit;

        campCharge();

      action = S.of(context).update;
      action2 = S.of(context).undo;
   }

    String name = S.of(context).company;
    String title1 = "$title $name";

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
                              Text(title1,
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).name),
                                ),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).discharge_date),
                                ),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 200.0),
                                  child: Text(S.of(context).sector),
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

                                               if(sectorChoose == S.of(context).newMale)
                                               {

                                                     String modif = S.of(context).newMale;
                                                     bool create = await createSector(context,modif);

                                                       if(create == true)
                                                       {
                                                           setState((){
                                                               String action = S.of(context).the_sector_has_been_created_successfully;
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
                          Row(
                            children: [
                              Text(
                                S.of(context).contact,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).phone_1),
                                ),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 85.0,right: 10.0),
                                  child:  Text(S.of(context).phone_2),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).email),
                                ),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 70.0,right: 10.0),
                                  child: Text(S.of(context).web_page),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).address),
                                ),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(S.of(context).city),
                                ),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 85.0, right: 10.0),
                                  child: Text(S.of(context).postal_code),
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
                               Padding(
                                 padding: const EdgeInsets.only(right: 10.0),
                                 child: Text(S.of(context).province),
                               ),
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
                          Row(
                            children: [
                              Text(
                                S.of(context).company_contacts,
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
                                                        String action =S.of(context).the_employee_has_been_correctly_removed;
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

                                      List <Factory> current=[];
                                      List <String> allKeys = [];
                                      String nameCamp = S.of(context).name;

                                      for (int i = 0; i < allFactories.length; i++)
                                      {
                                           allKeys.add(allFactories[i].name);
                                      }

                                      String campOld = " ";

                                      if(select != -1)
                                      {
                                        campOld = allFactories[select].name;
                                      }

                                      if(primaryKeyCorrect(controllerName.text,nameCamp,allKeys,campOld,context) ==true) {
                                        final telephone1 = controllerTelephone1
                                            .text.replaceAll(" ", "");
                                        final telephone2 = controllerTelephone2
                                            .text.replaceAll(" ", "");

                                        if (dateCorrect(controllerHighDate.text) == false) {

                                          String array = S.of(context).date;
                                          String action = LocalizationHelper.format_must(context, array);

                                          String format = 'DD-MM-AAAA';
                                          error(context, action, format);
                                        }
                                        if (campEmpty(controllerSector.text) ==
                                            true) {
                                          String campo=S.of(context).sector;
                                          String action = LocalizationHelper.camp_empty(context, campo);
                                          error(context, action);
                                        }
                                        else if (telephoneCorrect(
                                            telephone1, context) == false) {


                                        }
                                        else if (telephoneCorrect(
                                            telephone2, context) == true) {

                                        }
                                        else
                                        if (mailCorrect(controllerMail.text) !=
                                            true) {
                                          action = S.of(context).not_a_valid_email;
                                          error(context, action);
                                        }
                                        else
                                        if (webCorrect(controllerWeb.text) !=
                                            true) {
                                          action = S.of(context).not_a_valid_webpage;
                                          error(context, action);
                                        }
                                        else if (adrressCorrect(
                                            controllerAdrress.text) != true) {
                                          String array = S.of(context).address;
                                          String action = LocalizationHelper.format_must(context, array);
                                          String street = S.of(context).street;
                                          String number = S.of(context).number;
                                          String format = '$street , $number';
                                          error(context, action, format);
                                        }
                                        else if (postalCodeCorrect(
                                            controllerPostalCode.text,
                                            context) == true) {
                                          if (controllerPostalCode.text
                                              .length != 5) {
                                            action =S.of(context).the_postal_code_must_have_5_digits;
                                            error(context, action);
                                          }
                                          else {
                                            List<
                                                String> adrress1 = controllerAdrress
                                                .text.split(",");
                                            List<
                                                String> adrress2 = controllerAdrress
                                                .text.split("-");
                                            String apartament = '';

                                            if (controllerAdrress.text.contains(
                                                "-")) {
                                              apartament = adrress2[1];
                                            }
                                            else {
                                              apartament = '';
                                            }
                                            List<String> num = adrress2[0]
                                                .split(",");

                                            if (conn != null) {
                                              Set<
                                                  Empleoye> contacsPreEdit1 = contacsPreEdit
                                                  .toSet();
                                              Set<
                                                  Empleoye> contacsCurrent1 = contacsCurrent
                                                  .toSet();

                                              Set<
                                                  Empleoye> empleoyesNew = contacsCurrent1
                                                  .difference(contacsPreEdit1);

                                              sqlCreateEmpleoye(
                                                  empleoyesNew.toList());
                                              empleoyes.addAll(empleoyesNew);

                                              Set<
                                                  Empleoye> empleoyesDelete = contacsPreEdit1
                                                  .difference(contacsCurrent1);

                                              List<
                                                  Empleoye> empleoyesDelete1 = empleoyesDelete
                                                  .toList();
                                              sqlDeleteEmpleoyes(
                                                  empleoyesDelete1);

                                              String current = "";

                                              for (int i = 0; i <
                                                  empleoyesDelete1
                                                      .length; i++) {
                                                current =
                                                    empleoyesDelete1[i].id;

                                                for (int x = 0; x <
                                                    empleoyes.length; x++) {
                                                  if (current ==
                                                      empleoyes[i].id) {
                                                    empleoyes.removeAt(x);
                                                  }
                                                }
                                              }
                                            }
                                            if (select == -1) {
                                              String idNew = "";

                                              if (allFactories.isNotEmpty) {
                                                String idLast = allFactories[allFactories
                                                    .length - 1].id;
                                                idNew = createId(idLast);
                                              }
                                              else {
                                                idNew = "1";
                                              }

                                              current.add(Factory(
                                                id: idNew,
                                                name: controllerName.text,
                                                highDate: controllerHighDate
                                                    .text,
                                                sector: controllerSector.text,
                                                thelephones: [
                                                  controllerTelephone1.text,
                                                  controllerTelephone2.text
                                                ],
                                                mail: controllerMail.text,
                                                web: controllerWeb.text,
                                                address: {
                                                  'street': adrress1[0],
                                                  'number': num[1],
                                                  'apartament': apartament,
                                                  'city': controllerCity.text,
                                                  'postalCode': controllerPostalCode
                                                      .text,
                                                  'province': controllerProvince
                                                      .text,
                                                },
                                              ));

                                            }
                                            else {
                                              if (saveChanges == true) {
                                                allFactories[select].name =
                                                    controllerName.text;
                                                allFactories[select].highDate =
                                                    controllerHighDate.text;
                                                allFactories[select].sector =
                                                    controllerSector.text;
                                                allFactories[select]
                                                    .thelephones = [
                                                  controllerTelephone1.text,
                                                  controllerTelephone2.text
                                                ];
                                                allFactories[select].mail =
                                                    controllerMail.text;
                                                allFactories[select].web =
                                                    controllerWeb.text;
                                                allFactories[select]
                                                    .address['street'] =
                                                adrress1[0];
                                                allFactories[select]
                                                    .address['number'] = num[1];
                                                allFactories[select]
                                                    .address['apartament'] =
                                                    apartament;
                                                allFactories[select]
                                                    .address['city'] =
                                                    controllerCity.text;
                                                allFactories[select]
                                                    .address['postalCode'] =
                                                    controllerPostalCode.text;

                                              }
                                            }
                                            saveChanges = false;

                                            if (conn != null) {
                                              if (select == -1) {
                                                sqlCeateFactory(current);
                                              }
                                              else {
                                                current.add(
                                                    allFactories[select]);
                                                sqlModifyFActory(current);
                                              }
                                            }
                                            else {
                                              allFactories =
                                                  allFactories + current;
                                              csvExportatorFactories(
                                                  allFactories);

                                              empleoyes = [
                                                ...{
                                                  ...empleoyes,
                                                  ...contacsCurrent
                                                }
                                              ];

                                              String idCurrent = "";
                                              for (int i = 0; i <
                                                  idsDelete.length; i++) {
                                                idCurrent = idsDelete[i];

                                                for (int y = 0; y <
                                                    empleoyes.length; y++) {
                                                  if (idCurrent ==
                                                      empleoyes[y].id) {
                                                    empleoyes.removeAt(y);
                                                  }
                                                }
                                              }
                                              csvExportatorEmpleoyes(empleoyes);
                                              bool errorExp = await csvExportatorFactories(
                                                  allFactories);

                                              String array = S.of(context).companies;

                                              if (errorExp == false)
                                              {

                                                String actionArray = S.of(context).saved;

                                                String action = LocalizationHelper.manage_array(context, array, actionArray);
                                                await confirm(context, action);
                                              }
                                              else
                                              {
                                                String action = LocalizationHelper.no_file(context, array);
                                                warning(context, action);
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }),

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



