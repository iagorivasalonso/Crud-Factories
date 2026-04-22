import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/Global/controllers/Factory.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
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
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/createSector.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart';
import 'package:crud_factories/Widgets/listElements.dart';
import 'package:crud_factories/Widgets/materialButton.dart';




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

  List<Empleoye> contacsCurrent = [];
  List<Empleoye> contacsPreEdit = [];
  List<String> idsDelete = [];
  List<String> sectorsString = [];

  DateTime seletedDate =DateTime.now();

  int contactSelect = 0;
  String id ="";
  String date="";
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

    if (widget.factorySelect != null && widget.select != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        campCharge();
        setState(() {});
      });
    }
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
  void didUpdateWidget(covariant newFactory oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.factorySelect?.id != oldWidget.factorySelect?.id) {
      campCharge();
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;
    int select = widget.select;
    sectorsString.clear();



    String action = S.of(context).update;
    String action2 = "";
    String title = "";


    if (select == -1) {
      title = S.of(context).newFemale;
      action = S.of(context).create;
      action2 = S.of(context).reboot;

      if (allFactories.isNotEmpty) {
        String idLast = allFactories[allFactories
            .length - 1].id;
        id = createId(idLast);
      }
      else {
        id = "1";
      }

    }
    else {
      title = S.of(context).edit;

      action = S.of(context).update;
      action2 = S.of(context).undo;
   }

    final Sector newSectorOption = Sector(
        id: "new",
        name: S.of(context).newMale,
    );

    String name = S.of(context).company;
    String title1 = "$title $name";

    return !isNotAndroid()
       ? Scaffold(
      body: Scrollbar(
        controller: verticalScroll,
        thumbVisibility: true,
        notificationPredicate: (notification) =>
        notification.metrics.axis == Axis.vertical,
        child: Scrollbar(
          controller: horizontalScroll,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: verticalScroll,
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              controller: horizontalScroll,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 856,
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
                                      campOld: select == -1 ? '' : widget.factorySelect!.highDate,
                                      controllerCamp: controllers.highDate,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100),
                                Flexible(
                                  child: GenericDropdown<Sector>(
                                    items: [
                                      if(select==-1)
                                      newSectorOption,
                                      ...sectors
                                    ],
                                    camp:S.of(context).sector,
                                    selectedItem: selectedSector,
                                    hint:  S.of(context).select,
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

                          layoutVariant(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              items: [
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

                          layoutVariant(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              items: [
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
                            campOld: select == -1 ? '' : allAddress,
                          ),
                          layoutVariant(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              items: [
                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).city,
                                    controllerCamp: controllers.city,
                                    campOld: select == -1 ? '' : widget.factorySelect!.address['city']
                                  ),
                                ),

                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).postal_code,
                                    controllerCamp: controllers.postalCode,
                                    campOld: select == -1 ? '' : widget.factorySelect!.address['city'],
                                  ),
                                ),
                              ]
                          ),

                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 400,
                              child: defaultTextfield(
                                nameCamp: S.of(context).province,
                                controllerCamp: controllers.province,
                                campOld: select == -1 ? '' : widget.factorySelect!.address['province']!,
                              ),
                            ),
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
                                padding: const EdgeInsets.only(left: 600.0, top:100.0,bottom: 20.0),
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
      ),
    )
       : Scaffold(
           appBar: appBarAndroid(context, name: title1),
           body: Text("factori"),
        );
  }
  void campCharge () {

      id = widget.factorySelect!.id;

      controllers.name.text = widget.factorySelect!.name;
      controllers.highDate.text = widget.factorySelect!.highDate;
      tmp = widget.factorySelect!.sector;

      selectedSector = sectors.firstWhere(
            (s) => s.id == tmp,
        orElse: () => sectors.first,
      );

      controllers.sector.text = selectedSector!.name;

      controllers.telephone1.text = widget.factorySelect!.thelephones[0];
      controllers.telephone2.text =  widget.factorySelect!.thelephones[1];
      controllers.mail.text =  widget.factorySelect!.mail;
      controllers.web.text =  widget.factorySelect!.web;

      var address =  widget.factorySelect!.address['street']!;
      var number =  widget.factorySelect!.address['number']!;
      var apartament =  widget.factorySelect!.address['apartament']!;


      allAddress = apartament == ""
          ? '$address,$number'
          : '$address,$number-$apartament';

      controllers.address.text = allAddress!;
      controllers.city.text =  widget.factorySelect!.address['city']!;
      controllers.postalCode.text =  widget.factorySelect!.address['postalCode']!;
      controllers.province.text =  widget.factorySelect!.address['province']!;


      String idFactory = widget.factorySelect!.id;


      contacsPreEdit.clear();
      contacsCurrent.clear();


      for (var e in empleoyes) {
        if (e.idFactory == idFactory) {
          contacsPreEdit.add(e);
          contacsCurrent.add(e);
        }
      }

  }
  Future<void> _onSectorChanged(BuildContext context,Sector? sectorChoose,int select) async {

    if (sectorChoose == null) return;

    if (sectorChoose!.name == S.of(context).newMale)
    {
        final newSector = await createSector(context, "");

        if(newSector != null)
        {
           setState(() {
              selectedSector = newSector;
              controllers.sector.text = newSector.name;
           });
        }
    }
    else if (saveChanges == false && select != -1)
    {
      saveChanges = true;
    }
    else
    {
      selectedSector = sectors.firstWhere((s) => s.id == sectorChoose.id);

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

  Future<void> _onSaveFactory(
      BuildContext context,
      int select,
      factoryController controllers,
      contacsPreEdit,
      contacsCurrent,
      List<String> idsDelete,
      ) async {

    final allKeys = allFactories.map((f) => f.name).toList();
    final campOld = select != -1 ? allFactories[select].name : "";

    final nameError = ValidatorCamps.primaryKeyValidate(
      controllers.name.text,
      allKeys,
      campOld,
      context,
    );

    final isSameSelected = (select != -1 && controllers.name.text == allFactories[select].name);

    if (nameError != null && !isSameSelected) {
      error(context, nameError);
      return;
    }

    final dateError = ValidatorCamps.dateValidate(
      controllers.highDate.text,
      context,
    );

    if (dateError != null) {
      String format = 'DD-MM-AAAA';
      error(context, dateError, format);
      return;
    }

    final sectorError = ValidatorCamps.emptyValidate(
      controllers.sector.text,
      context,
      S.of(context).sector,
    );

    if (sectorError != null) {
      error(context, sectorError);
      return;
    }

    final mailError = ValidatorCamps.mailValidate(
      controllers.mail.text,
      context,
    );

    if (mailError != null) {
      error(context, mailError);
      return;
    }

    final tel1 = controllers.telephone1.text.replaceAll(" ", "");
    final tel2 = controllers.telephone2.text.replaceAll(" ", "");

    final tel1Error = ValidatorCamps.telephoneValidate(
      tel1,
      context,
    );

    if (tel1Error != null) {
      error(context, tel1Error);
      return;
    }

    final tel2Error = ValidatorCamps.telephoneValidate(
      tel2,
      context,
    );

    if (tel2Error != null) {
      error(context, tel2Error);
      return;
    }
    // ---- ADDRESS PARSE ----

    final addressError = ValidatorCamps.addressValidate(
      controllers.address.text,
      context,
    );

    if (addressError != null) {
      String array = S.of(context).date;
      String action = LocalizationHelper.format_must(context, array);

      String format = 'DD-MM-AAAA';
      error(context, action, format);
      return;
    }

    final addressText = controllers.address.text;

    final partsDash = addressText.split("-");
    final apartament = partsDash.length > 1 ? partsDash[1] : "";

    final partsComma = partsDash[0].split(",");
    final street = partsComma.isNotEmpty ? partsComma[0] : "";
    final number = partsComma.length > 1 ? partsComma[1] : "";

    final postalError = ValidatorCamps.postalCodeValidate(
      controllers.postalCode.text,
      context,
    );

    if (postalError != null) {
      error(context, postalError);
      return;
    }

    // ---- CREATE OR UPDATE ----
    if (select == -1) {
      allFactories.add(
        Factory(
          id: id,
          name: controllers.name.text,
          highDate: controllers.highDate.text,
          sector: selectedSector!.id,
          thelephones: [tel1, tel2],
          mail: controllers.mail.text,
          web: controllers.web.text,
          address: {
            'street': street,
            'number': number,
            'apartament': apartament,
            'city': controllers.city.text,
            'postalCode': controllers.postalCode.text,
            'province': controllers.province.text,
          },
        ),
      );
    } else if (saveChanges) {
      final f = allFactories[select];
      f.name = controllers.name.text;
      f.highDate = controllers.highDate.text;
      f.sector = selectedSector!.id;
      f.thelephones = [tel1, tel2];
      f.mail = controllers.mail.text;
      f.web = controllers.web.text;
      f.address['street'] = street;
      f.address['number'] = number;
      f.address['apartament'] = apartament;
      f.address['city'] = controllers.city.text;
      f.address['postalCode'] = controllers.postalCode.text;
    }

    saveChanges = false;
    empleoyes.removeWhere((e) => idsDelete.contains(e.id));

// Añade o actualiza los actuales
    for (var e in contacsCurrent) {
      final index = empleoyes.indexWhere((emp) => emp.id == e.id);

      if (index == -1) {
        empleoyes.add(e); // nuevo
      } else {
        empleoyes[index] = e; // update
      }
    }
    // ---- EXPORT ONLY ONCE ----
    final empOk = await csvExportatorEmpleoyes(empleoyes);
    final facOk = await csvExportatorFactories(allFactories);

    if (facOk && empOk) {
      await confirm(
        context,
        LocalizationHelper.manage_array(
          context,
          S.of(context).company,
          S.of(context).saved_female,
          S.of(context).theFemale,
        ),
      );
    } else {

      if (!kIsWeb) {
        warning(
          context,
          LocalizationHelper.no_file(context, S.of(context).company),
        );
      }

    }
    await _onResetFactory(context, select, controllers, contacsCurrent);
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
      controllers.address.clear();
      controllers.city.clear();
      controllers.postalCode.clear();
      controllers.province.clear();
      controllers.contacts.clear();
      controllers.employee.clear();
      selectedSector = null;
      controllers.sector.clear();

      setState(() {
        contacsCurrent.clear();
      });
      controllers.employeeNew.clear();
    }
    else {
      campCharge();
    }

    saveChanges = false;
  }


}



