import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show CreateResult, EditResult;
import 'package:crud_factories/Backend/Global/controllers/Factory.dart';
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart';
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Objects/Empleoye.dart';
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Validators/factory.dart' show FactoryValidator, AddressParser;
import 'package:crud_factories/Widgets/headView.dart';
import 'package:crud_factories/Widgets/layoutVariant.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfieldCalendar.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/createSector.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/dropDownButton.dart';
import 'package:crud_factories/Widgets/listElements.dart';
import 'package:crud_factories/Widgets/materialButton.dart';
import 'package:provider/provider.dart';




class FactoryFromPage extends StatefulWidget {

  FactoryFromPage();

  @override
  State<FactoryFromPage> createState() => _FactoryFromPageState();
}

class _FactoryFromPageState extends State<FactoryFromPage> {

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();


  List<String> idsDelete = [];

  List<Empleoyee> newEmployeesTemp = [];

  Sector? selectedSector;

  late final factoryController controllers;
  Empleoyee? selectedEmployee;

  List<String> pendingDelete = [];

  @override
  void initState() {
    super.initState();
    controllers = factoryController(
      name: TextEditingController(),
      highDate: TextEditingController(),
      telephone1: TextEditingController(),
      telephone2: TextEditingController(),
      mail: TextEditingController(),
      web: TextEditingController(),
      address: TextEditingController(),
      city: TextEditingController(),
      postcode: TextEditingController(),
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
    controllers.telephone1.dispose();
    controllers.telephone2.dispose();
    controllers.mail.dispose();
    controllers.web.dispose();
    controllers.address.dispose();
    controllers.city.dispose();
    controllers.postcode.dispose();
    controllers.province.dispose();
    controllers.employee.dispose();
    controllers.employeeNew.dispose();
    for (final c in controllers.contacts) {
      c.dispose();
    }
    super.dispose();
  }

  String? _lastFactoryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final factory = context.read<FactoryProvider>().selected;

    if (factory == null) return;

    if (_lastFactoryId != factory.id) {
      _lastFactoryId = factory.id;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          loadSelectedFactory(factory);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final factorySelected = context.watch<FactoryProvider>().selected;


    final isEditing = factorySelected != null;
    final Sector newSectorOption = Sector(
      id: "-",
      name: S.of(context).newMale,
    );



    final title = isEditing
        ? S.of(context).edit
        : S.of(context).newFemale;

    final action = isEditing
        ? S.of(context).update
        : S.of(context).create;

    final action2 = isEditing
        ? S.of(context).undo
        : S.of(context).reboot;


    String name = S.of(context).company;
    String title1 = "$title $name";



    final factoryId = isEditing
        ? factorySelected!.id
        : createNextFactoryId(context.read<FactoryProvider>().factories);

    final employeesProvider = context
        .watch<EmployeeProvider>()
        .empleoyees
        .where((e) => e.idFactory == factoryId)
        .where((e) => !idsDelete.contains(e.id))
        .toList();

    final employees = [
      ...employeesProvider,
      ...newEmployeesTemp,
    ];

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
                            campOld: factorySelected?.name ?? '',
                            context: context,
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
                                      context: context,
                                      nameCamp: S.of(context).discharge_date,
                                      campOld: factorySelected?.highDate ?? '',
                                      controllerCamp: controllers.highDate,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 100),
                                Flexible(
                                  child: GenericDropdown<Sector>(
                                    items: [
                                      if (!isEditing)
                                      newSectorOption,
                                      ...context.watch<SectorProvider>().sectors
                                    ],
                                    camp:S.of(context).sector,
                                    selectedItem: selectedSector,
                                    hint:  S.of(context).select,
                                    itemLabel: (sector) => sector.name,
                                    onChanged: (sectorChoose) =>
                                        _onSectorChanged(context, sectorChoose,isEditing),

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
                                    campOld: factorySelected?.thelephones.isNotEmpty == true
                                        ? factorySelected!.thelephones[0]
                                        : '',
                                    context: context,
                                  ),
                                ),

                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).phone_2,
                                    controllerCamp: controllers.telephone2,
                                    campOld: (factorySelected?.thelephones.length ?? 0) > 1
                                        ? factorySelected?.thelephones[1] ?? ''
                                        : '',
                                    context: context,
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
                                    campOld: factorySelected?.mail ?? '',
                                    context: context,
                                  ),
                                ),

                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).web_page,
                                    controllerCamp: controllers.web,
                                    campOld: factorySelected?.web ?? '',
                                    context: context,
                                  ),
                                ),
                              ]
                          ),

                          defaultTextfield(
                            nameCamp: S.of(context).address,
                            controllerCamp: controllers.address,
                            campOld: factorySelected?.address.fullAddress ?? '',
                            context: context,
                          ),
                          layoutVariant(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              items: [
                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).city,
                                    controllerCamp: controllers.city,
                                    campOld: factorySelected?.address.city ?? '',
                                    context: context,
                                  ),
                                ),

                                Flexible(
                                  child: defaultTextfield(
                                    nameCamp: S.of(context).postal_code,
                                    controllerCamp: controllers.postcode,
                                    campOld : factorySelected?.address.postcode ?? '',
                                    context: context,
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
                                campOld: factorySelected?.address.province ?? '',
                                context: context,
                              ),
                            ),
                          ),


                          layoutVariant(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            items: [

                              // TEXTFIELD
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    height: 120, // 👈 clave para igualar con la lista
                                    child: defaultTextfield(
                                      nameCamp: S.of(context).employees,
                                      controllerCamp: controllers.employeeNew,
                                      campOld: '',
                                      context: context,
                                    ),
                                  ),
                                ),
                              ),

                              // BOTONES (uno debajo del otro)
                              Padding(
                                padding: const EdgeInsets.only(top: 70.0,right: 20.0), // 👈 baja los botones
                                child: SizedBox(
                                  width: 50,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      materialButton(
                                        icon: const Icon(Icons.add),
                                        function: () => _addEmplepoye(context, controllers, factoryId),
                                      ),
                                      const SizedBox(height: 12),
                                      materialButton(
                                        icon: const Icon(Icons.delete),
                                        function: () => _deleteEmplepoye(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // LISTA
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SizedBox(
                                    height: 170,
                                    child: Container(
                                      width: 250,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: ContactList(
                                        contacsCurrent:employees,
                                        selected: selectedEmployee,
                                        onSelect: (e) {
                                          setState(() => selectedEmployee = e);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
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
                                        function: () =>_onSaveFactory(
                                                context,
                                                factorySelected,
                                                controllers,
                                                factoryId
                                            )
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: materialButton(
                                        nameAction: action2,
                                        function: () =>
                                            _onResetFactory(
                                                context,
                                                controllers,
                                                factorySelected,
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

  void loadSelectedFactory(Factory factory) {
    controllers.name.text = factory.name;
    controllers.highDate.text = factory.highDate;


    controllers.telephone1.text =
    factory.thelephones.isNotEmpty ? factory.thelephones[0] : '';

    controllers.telephone2.text =
    factory.thelephones.length > 1 ? factory.thelephones[1] : '';

    controllers.mail.text = factory.mail;
    controllers.web.text = factory.web;

    controllers.address.text =
        factory.address.fullAddress; // mejor que reconstruir manualmente

    controllers.city.text = factory.address.city;
    controllers.postcode.text = factory.address.postcode;
    controllers.province.text = factory.address.province;

    selectedEmployee = null;
  }

  Future<void> _onSectorChanged(BuildContext context,Sector? sectorChoose, bool isEditing) async {

    final providerSectors = context.read<SectorProvider>();

    if (sectorChoose == null) return;

    if (sectorChoose.name == S.of(context).newMale)
    {
        final sector = await createSector(context);

        if(sector != null)
        {
          final result = await providerSectors.create(sector);

          switch (result) {
            case CreateResult.success:
              await confirm(context,S.of(context).sector_created_successfully);
              break;
            case CreateResult.alreadyExists:
              await error(context,S.of(context).sector_already_exists);
              break;
            case CreateResult.invalidData:
              await error(context, S.of(context).not_valid);
              break;
          }
        }
    }
    else if (!context.read<EditStateProvider>().hasChanges && isEditing)
    {
      context.read<EditStateProvider>().markChanged();
    }

      selectedSector = providerSectors.sectors.firstWhere(
              (s) => s.id == sectorChoose.id,
      );

      setState(() {
        selectedSector = sectorChoose;
      });

  }

  Future<void> _addEmplepoye(BuildContext context,factoryController controllers, String idFactory) async {

    final employees = context.read<EmployeeProvider>().empleoyees;

    if (controllers.employeeNew.text.trim().isEmpty) {
      return;
    }

    final maxId = employees.isEmpty
        ? 0
        : employees
        .map((e) => int.tryParse(e.id) ?? 0)
        .reduce((a, b) => a > b ? a : b);




    final newEmployee = Empleoyee(
      id: (maxId + 1).toString(),
      name: controllers.employeeNew.text,
      idFactory: idFactory,
    );


    setState(() {
      newEmployeesTemp.add(newEmployee);
    });
    controllers.employeeNew.clear();

  }

  Future<void> _deleteEmplepoye(BuildContext context) async {

    if (selectedEmployee == null) return;

    final employee = selectedEmployee!;

    setState(() {
      newEmployeesTemp.removeWhere((e) => e.id == employee.id);

      if (!idsDelete.contains(employee.id)) {
        idsDelete.add(employee.id);
      }

      selectedEmployee = null;
    });

    confirm(context, S.of(context).the_employee_has_been_correctly_removed);
  }

  Future<void> _onSaveFactory(
      BuildContext context,
      Factory? factorySelected,
      factoryController controllers,
      String factoryId
      ) async {
            final isEditing = factorySelected != null;
            
            final factoryProvider = context.read<FactoryProvider>();

            final tel1 = controllers.telephone1.text.replaceAll(" ", "");
            final tel2 = controllers.telephone2.text.replaceAll(" ", "");

            final errorMsg = FactoryValidator.validate(
              context,
              controllers,
              factorySelected,
              factoryProvider.factories,
            );

            if (errorMsg != null) {
              error(context, errorMsg);
              return;
            }

            final address = AddressParser.parse(
               controllers.address.text,
               controllers.city.text,
               controllers.province.text,
               controllers.postcode.text
             );

            final factory = Factory(
                id: isEditing ? factorySelected!.id : factoryId,
                name: controllers.name.text,
                highDate: controllers.highDate.text,
                sector: selectedSector?.id ?? "",
                thelephones: [tel1,tel2] ,
                mail: controllers.mail.text,
                web: controllers.web.text,
                address: address
            );

            factoryProvider.select(factory);
            if (!isEditing)
            {
                final result = await factoryProvider.create(factory);

                switch(result){
                  case CreateResult.success:
                    await confirm(context,S.of(context).factory_created_successfully);
                  break;

                  case CreateResult.alreadyExists:
                    await error(context, S.of(context).factory_already_exists);
                  break;
                  case CreateResult.invalidData:
                    await error(context, S.of(context).factory_save_error);
                }

                await _onResetFactory(context, controllers);
            }
            else
            {
                 final result = await factoryProvider.update(factory);

                 switch(result)
                 {

                   case EditResult.success:

                     await confirm(context,S.of(context).factory_updated_successfully);
                   break;

                   case EditResult.alreadyExists:
                     await error(context, S.of(context).factory_already_exists);
                   break;

                   case EditResult.notFound:
                     await error(context,S.of(context).factory_not_found);
                   break;

                   case EditResult.invalidData:
                     await error(context, S.of(context).invalid_data);
                    break;
                   case EditResult.error:
                     // TODO: Handle this case.
                     throw UnimplementedError();
                 }
            }

            final providerEmployees = context.read<EmployeeProvider>();

             // Empleados eliminados
              await providerEmployees.removeEmployees(idsDelete);
              idsDelete.clear();

             // Empleados nuevos

            for (final e in newEmployeesTemp) {
              await providerEmployees.addEmployees([e]);
            }

            newEmployeesTemp.clear();


  }

  Future<void> _onResetFactory(
      BuildContext context,
      factoryController controllers,
      [Factory? factorySelected]
      ) async {
    context.read<EditStateProvider>().clear();

    controllers.name.clear();
    controllers.highDate.clear();
    controllers.telephone1.clear();
    controllers.telephone2.clear();
    controllers.mail.clear();
    controllers.web.clear();
    controllers.address.clear();
    controllers.city.clear();
    controllers.postcode.clear();
    controllers.province.clear();

    controllers.employeeNew.clear();

    selectedSector = null;
    selectedEmployee = null;

    idsDelete.clear();
    newEmployeesTemp.clear();

    setState(() {});
  }

  String createNextFactoryId(List<Factory> factories) {
    final ids = factories
        .map((f) => int.tryParse(f.id))
        .whereType<int>();

    final maxId = ids.isEmpty ? 0 : ids.reduce((a, b) => a > b ? a : b);

    return (maxId + 1).toString();
  }
}
