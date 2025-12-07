import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/create%20sector.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/Global/controllers/Factory.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/createEmpleoye.dart';
import 'package:crud_factories/Backend/SQL/createFactory.dart';
import 'package:crud_factories/Backend/SQL/deleteEmpleoyes.dart';
import 'package:crud_factories/Backend/SQL/modifyFactory.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV//exportFactories.dart';
import 'package:crud_factories/Functions/createId.dart';
import 'package:crud_factories/Functions/validatorCamps.dart';
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfieldCalendar.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';

import '../Widgets/dropDownButton.dart';
import '../Widgets/listElements.dart';
import '../Widgets/materialButton.dart';




class newFactory extends StatefulWidget {

  int select;
  Factory? factorySelect;


  newFactory(this.select,[this.factorySelect]);

  @override
  State<newFactory> createState() => _newFactoryState();
}

class _newFactoryState extends State<newFactory> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();

  double widthBar = 10.0;

  List<Empleoye> contacsCurrent = [];
  List<Empleoye> contacsPreEdit = [];
  List<String> idsDelete = [];
  List<String> sectorsString = [];

  DateTime seletedDate =DateTime.now();

  int contactSelect = 0;
  String id ="";
  String date="";
  String sector = " ";
  Sector? selectedSector;
  String tmp = " ";
  String allAddress = "";
  late final factoryController controllers;

  @override
  void initState() {
    super.initState();
    controllers = factoryController(
      name: TextEditingController(),
      highDate: TextEditingController(),
      sector: TextEditingController(),
      telephone1: TextEditingController(),
      telephone2: TextEditingController(),
      mail: TextEditingController(),
      web: TextEditingController(),
      address: TextEditingController(),
      city: TextEditingController(),
      postalCode: TextEditingController(),
      province: TextEditingController(),
      contacts: [TextEditingController()],
      employee: TextEditingController(),
      employeeNew: TextEditingController(),
    );
  }

  @override
  void dispose() {
    controllers.name.dispose();
    controllers.highDate.dispose();
    controllers.sector.dispose();
    controllers.telephone1.dispose();
    controllers.telephone2.dispose();
    controllers.mail.dispose();
    controllers.web.dispose();
    controllers.address.dispose();
    controllers.city.dispose();
    controllers.postalCode.dispose();
    controllers.province.dispose();
    controllers.employee.dispose();
    controllers.employeeNew.dispose();
    for (final c in controllers.contacts) {
      c.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;
    int select = widget.select;
    sectorsString.clear();

    sectorsString.add(S.of(context).newMale);

      for(int i = 0; i < sectors.length; i++)
      {
          sectorsString.add(sectors[i].name);
      }

    void campCharge () {

      if(saveChanges == false)
      {
            controllers.name.text = widget.factorySelect!.name;
            controllers.highDate.text = widget.factorySelect!.highDate;
            tmp = widget.factorySelect!.sector;
            controllers.sector.text = tmp;

            for(int i = 0; i <sectors.length; i++)
            {
              if(tmp == sectors[i].id)
              {
                sector = sectors[i].name;
              }
            }

            controllers.telephone1.text = widget.factorySelect!.thelephones[0];
            controllers.telephone1.text =  widget.factorySelect!.thelephones[1];
            controllers.mail.text =  widget.factorySelect!.mail;
            controllers.web.text =  widget.factorySelect!.web;

            var address =  widget.factorySelect!.address['street']!;
            var number =  widget.factorySelect!.address['number']!;
            var apartament =  widget.factorySelect!.address['apartament']!;

            if (apartament == "")
            {
              allAddress = '$address,$number';
            }
            else
            {
              allAddress = '$address,$number-$apartament';
            }
            controllers.address.text = allAddress!;
            controllers.city.text =  widget.factorySelect!.address['city']!;
            controllers.postalCode.text =  widget.factorySelect!.address['postalCode']!;
            controllers.province.text =  widget.factorySelect!.address['province']!;


            int idFactory = widget.select +1;


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

    return Platform.isWindows
       ? Scaffold(
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
                        headView(
                            title: title1
                        ),

                        defaultTextfield(
                          nameCamp: S.of(context).name,
                          controllerCamp: controllers.name,
                          campOld: select == -1 ? '' : widget.factorySelect!.name,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                          child: layoutVariant(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            items: [

                              Flexible(
                                child: SizedBox(
                                  width: 600,
                                  child: textfieldCalendar(
                                    nameCamp: S.of(context).discharge_date,
                                    campOld: "",
                                    controllerCamp: controllers.highDate,
                                  ),
                                ),
                              ),
                              SizedBox(width: 100),
                              Flexible(
                                child: GenericDropdown<Sector>(
                                  items: sectors,
                                  camp:S.of(context).sector,
                                  opDefault: S.of(context).newMale,
                                  selectedItem: selectedSector,
                                  hint: sector,
                                  itemLabel: (sector) => sector.name,
                                  onChanged: (sectorChoose) =>
                                      _onSectorChanged(context, sectorChoose, select),
                                ),
                              ),
                            ],
                          ),
                        ),

                        headView(
                            title: S.of(context).contact
                        ),

                        Row(
                            children: [
                              Flexible(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).phone_1,
                                  controllerCamp: controllers.telephone1,
                                  campOld: select == -1 ? '' : widget.factorySelect!.thelephones[0],
                                ),
                              ),

                              Flexible(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).phone_2,
                                  controllerCamp: controllers.telephone2,
                                  campOld: select == -1 ? '' : widget.factorySelect!.thelephones[1],
                                ),
                              ),
                            ]
                        ),

                        Row(
                            children: [
                              Flexible(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).mail,
                                  controllerCamp: controllers.mail,
                                  campOld: select == -1 ? '' : widget.factorySelect!.mail,
                                ),
                              ),

                              Flexible(
                                child: defaultTextfield(
                                  nameCamp: S.of(context).web_page,
                                  controllerCamp: controllers.web,
                                  campOld: select == -1 ? '' : widget.factorySelect!.web,
                                ),
                              ),
                            ]
                        ),

                        defaultTextfield(
                          nameCamp: S.of(context).address,
                          controllerCamp: controllers.address,
                          campOld: select == -1 ? '' : widget.factorySelect!.address['city']!,
                        ),


                        defaultTextfield(
                          nameCamp: S.of(context).province,
                          controllerCamp: controllers.province,
                          campOld: select == -1 ? '' : widget.factorySelect!.address['province']!,
                        ),


                        layoutVariant(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          items: [
                            Flexible(
                              child: defaultTextfield(
                                nameCamp: S.of(context).employees,
                                controllerCamp: controllers.employeeNew,
                                campOld: '',
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: SizedBox(
                                width: 50,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: materialButton(
                                        icon: const Icon(Icons.add),
                                        function: () => _addEmplepoye(controllers, contacsCurrent, id),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    materialButton(
                                      icon: const Icon(Icons.delete),
                                      function: () => _deleteEmplepoye(
                                          contacsCurrent,
                                          idsDelete,
                                          contactSelect,
                                          context
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Flexible(
                              child: ContactList(contacsCurrent: contacsCurrent),
                            ),
                          ],
                        ),
                        Padding(
                              padding: const EdgeInsets.only(left: 600.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  materialButton(
                                      nameAction: action,
                                      function: () =>
                                          _onSaveFactory(
                                              context,
                                              select,
                                              controllers,
                                              contacsPreEdit,
                                              contacsCurrent,
                                              idsDelete
                                          )
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: materialButton(
                                      nameAction: action2,
                                      function: () =>
                                          _onResetFactory(
                                              context,
                                              select,
                                              controllers,
                                              contacsCurrent
                                          ),
                                    ),
                                  ),
                                ],
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
    )
       : Scaffold(
           appBar: appBarAndroid(context, name: title1),
           body: Text("factori"),
        );
  }

  Future<void> _onSectorChanged(BuildContext context,Sector? sectorChoose,int select) async {
    if (saveChanges == false && select != -1) {
      saveChanges = true;
    }


    if (sectorChoose == null)
    {
      String modif = "";
      bool create = await createSector(context, modif);

      if (create == true) {
        setState(() {});
      }
    }
    else
    {
      selectedSector = sectorChoose;

      setState(() {
        controllers.sector.text = sectorChoose!.name;
      });

    }
  }

  Future<void> _addEmplepoye(factoryController controllers,
      List<Empleoye> contacsCurrent, String id) async {
    setState(() {
      saveChanges = true;
      String idNew = "";
      contacsCurrent.clear();

      if (empleoyes.isNotEmpty) {
        String idLast = empleoyes.last.id;
        idNew = createId(idLast);
      } else {
        idNew = "1";
      }

      contacsCurrent.add(Empleoye(
        id: idNew,
        name: controllers.employeeNew.text,
        idFactory: id,
      ));
      print(contacsCurrent);
      controllers.employeeNew.clear();
    });
  }

  Future<void> _deleteEmplepoye(List<Empleoye> contacsCurrent,
      List<String> idsDelete, int contactSelect, BuildContext context) async {
    setState(() {
      saveChanges = true;

      Empleoye delete = contacsCurrent[contactSelect];
      idsDelete.add(delete.id);

      if (contacsCurrent[contactSelect] == delete) {
        contacsCurrent.removeAt(contactSelect);
        String action = S
            .of(context)
            .the_employee_has_been_correctly_removed;
        confirm(context, action);
      }
    });
  }

  Future<void> _onSaveFactory(BuildContext context, int select,
      factoryController controllers, contacsPreEdit, contacsCurrent,
      List<String> idsDelete) async {
    List <Factory> current = [];
    List <String> allKeys = [];
    String nameCamp = S
        .of(context)
        .name;
    String action = '';

    for (int i = 0; i < allFactories.length; i++) {
      allKeys.add(allFactories[i].name);
    }

    String campOld = " ";

    if (select != -1) {
      campOld = allFactories[select].name;
    }

    if (validatorCamps.primaryKeyCorrect(
        controllers.name.text, nameCamp, allKeys, campOld, context) == true) {
      final telephone1 = controllers.telephone1.text.replaceAll(" ", "");
      final telephone2 = controllers.telephone2.text.replaceAll(" ", "");

      if (validatorCamps.dateCorrect(controllers.highDate.text) == false) {
        String array = S
            .of(context)
            .date;
        String action = LocalizationHelper.format_must(context, array);

        String format = 'DD-MM-AAAA';
        error(context, action, format);
      }
      if (validatorCamps.campEmpty(controllers.sector.text) == true) {
        String campo = S
            .of(context)
            .sector;
        String action = LocalizationHelper.camp_empty(context, campo);
        error(context, action);
      }
      if (validatorCamps.telephoneCorrect(telephone1, context) == false) {


      }
      if (validatorCamps.telephoneCorrect(telephone2, context) == true) {

      }
      if (validatorCamps.mailCorrect(controllers.mail.text) != true) {
        action = S
            .of(context)
            .not_a_valid_mail;
        error(context, action);
      }
      if (validatorCamps.webCorrect(controllers.web.text) != true) {
        action = S
            .of(context)
            .not_a_valid_webpage;
        error(context, action);
      }
      else
      if (validatorCamps.adrressCorrect(controllers.address.text) != true) {
        String array = S
            .of(context)
            .address;
        String action = LocalizationHelper.format_must(context, array);
        String street = S
            .of(context)
            .street;
        String number = S
            .of(context)
            .number;
        String format = '$street , $number';

        error(context, action, format);
      }
      else {
        List<String> adrress1 = controllers.address.text.split(",");

        List<String> adrress2 = controllers.address.text.split("-");
        String apartament = '';

        if (controllers.address.text.contains("-")) {
          apartament = adrress2[1];
        }
        else {
          apartament = '';
        }
        List<String> num = adrress2[0].split(",");

        if (conn != null) {
          Set<Empleoye> contacsPreEdit1 = contacsPreEdit.toSet();
          Set<Empleoye> contacsCurrent1 = contacsCurrent.toSet();

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
            name: controllers.name.text,
            highDate: controllers.highDate.text,
            sector: controllers.sector.text,
            thelephones: [
              controllers.telephone1.text,
              controllers.telephone2.text,
            ],
            mail: controllers.mail.text,
            web: controllers.web.text,
            address: {
              'street': adrress1[0],
              'number': num[1],
              'apartament': apartament,
              'city': controllers.city.text,
              'postalCode': controllers.postalCode.text,
              'province': controllers.province.text,
            },
          ));
        }
        else {
          if (saveChanges == true) {
            allFactories[select].name = controllers.name.text;
            allFactories[select].highDate = controllers.highDate.text;
            allFactories[select].sector = controllers.sector.text;
            allFactories[select].thelephones = [
              controllers.telephone1.text,
              controllers.telephone2.text,
            ];
            allFactories[select].mail = controllers.mail.text;
            allFactories[select].web = controllers.web.text;
            allFactories[select].address['street'] = adrress1[0];
            allFactories[select].address['number'] = num[1];
            allFactories[select].address['apartament'] = apartament;
            allFactories[select].address['city'] = controllers.city.text;
            allFactories[select].address['postalCode'] =
                controllers.postalCode.text;
          }
        }
        saveChanges = false;

        if (conn != null) {
          if (select == -1) {
            sqlCreateFactory(current);
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

          String array = S
              .of(context)
              .company;

          if (errorExp == false) {
            String actionArray = S
                .of(context)
                .saved;
            String pr = S
                .of(context)
                .theFemale;

            String action = LocalizationHelper.manage_array(
                context, array, actionArray, pr);
            await confirm(context, action);
          }
          else {
            String action = LocalizationHelper.no_file(context, array);
            warning(context, action);
          }
        }
      }
    }
  }

  Future<void> _onResetFactory(BuildContext context, int select,
      factoryController controllers, List<Empleoye> contacsCurrent) async {
    if (select == -1) {
      controllers.name.clear();
      controllers.highDate.clear();
      controllers.telephone1.clear();
      controllers.telephone2.clear();
      controllers.mail.clear();
      controllers.web.clear();
      controllers.web.clear();
      controllers.city.clear();
      controllers.postalCode.clear();
      controllers.province.clear();
      controllers.contacts.clear();
      controllers.employee.clear();
      setState(() {
        contacsCurrent.clear();
      });
      controllers.employeeNew.clear();
    }
    else {
      //campCharge();
    }

    saveChanges = false;
  }


}



