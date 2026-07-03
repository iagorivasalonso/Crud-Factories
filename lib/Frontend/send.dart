import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Global/viewsModels/SendFrom.dart' show SendFromViewModel;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Backend/Providers/filterProvider.dart';
import 'package:crud_factories/Backend/Repositories/mailRepository.dart' show SendFromViewModel;
import 'package:crud_factories/Functions/isNotAndroid.dart' show isNotAndroid;
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/CustomDataTable.dart';
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:provider/provider.dart' show WatchContext, ReadContext, Consumer;
import 'package:collection/collection.dart';
import '../Backend/Providers/LineSendProvider.dart';
import '../Widgets/dropDownButton.dart';
import '../Widgets/materialButton.dart';
import '../Widgets/textfieldCalendar.dart';


class SendFromPage extends StatefulWidget {

 final List<LineSend> lines;
 final String? selectCamp;
 final SendFilter? filter;
 final int? select;

  SendFromPage({
    super.key,
    this.lines = const [],
    this.filter,
    this.selectCamp,
    this.select, required
  });

  @override
  State<SendFromPage> createState() => _SendFromPageState();
}

class _SendFromPageState extends State<SendFromPage> {


  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController verticalScrollTable = ScrollController();



  bool allSectors = false;



  @override
  void initState() {
    super.initState();


    vm = context.read<SendFromViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.init(
        isEditing: false,
        lines: widget.lines,
      );

        if(widget.lines.isNotEmpty)
        {
           final text = widget.filter == SendFilter.date
                ? widget.lines.first.date
                : widget.lines.first.factory;

           controllerSearchSend.text = text;

           vm.changueFilter(widget.lines, text,widget.filter);
        }
    });
  }

  @override
  void didUpdateWidget(covariant SendFromPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.lines != widget.lines ||
        oldWidget.filter != widget.filter) {

      if (widget.lines.isNotEmpty) {
        final text = widget.filter == SendFilter.date
            ? widget.lines.first.date
            : widget.lines.first.factory;

        controllerSearchSend.text = text;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            vm.changueFilter(widget.lines, text,widget.filter);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    horizontalScroll.dispose();
    verticalScroll.dispose();
    verticalScrollTable.dispose();

    super.dispose();
  }

  TextEditingController controllerSearchSend = TextEditingController();

  late SendFromViewModel vm;



  @override
  Widget build(BuildContext context0) {

    final vm = context.watch<SendFromViewModel>();
    final providerLines = context.watch<LineSendProvider>();

    final isEditing = widget.lines.isNotEmpty;

   String  action1 = isEditing
        ? S.of(context).save
        : S.of(context).newMale;

    String action2 = isEditing
        ? S.of(context).undo
        : S.of(context).reboot;

    final providerSectors = context
        .watch<SectorProvider>()
        .sectors;

    final selectedSector = providerSectors.firstWhereOrNull(
          (s) => s.id == vm.sectorId,
    );




    String messageResult = "";

    String campKey = "";
    String titleSector="";

    final sectorsWithFactories = providerSectors.where((sector) {
      return context
          .watch<FactoryProvider>()
          .factoriesBySector(sector.id)
          .isNotEmpty;
    }).toList();

    if(isEditing)
    {
         campKey = widget.filter == SendFilter.date
                   ?  S.of(context).company
                   :  S.of(context).date;

         final sectorId = context.watch<FilterProvider>().sectorId;

            if (sectorId=="0")
            {
               allSectors = widget.filter == SendFilter.date
                       ? true
                       : false;

               titleSector = widget.filter == SendFilter.date
                            ? S.of(context).allSectors
                            : S.of(context).list_of_sends;
            }
            else
            {
               allSectors = false;
               
               final sectorSelected = providerSectors.firstWhere(
                    (s) => s.id == sectorId
                );

               titleSector =  widget.filter == SendFilter.date
                   ? '${S.of(context).sectorOf} ${sectorSelected.name}'
                   : S.of(context).list_of_sends;
            }

            final lines = widget.lines;

            messageResult = widget.filter == SendFilter.date
                ?   LocalizationHelper.sendsDay(context, lines.length)
                :    LocalizationHelper.sendsDay(context, lines.length);

    }
    else
    {
          allSectors = selectedSector == null
                ? true
                : false;


          messageResult = LocalizationHelper.factoriesBD(context, vm.controllers.length);
    }

    return !isNotAndroid()
        ? Scaffold(
        body: Scrollbar(
          controller: verticalScroll,
          thumbVisibility: true,
          child: Scrollbar(
            controller: horizontalScroll,
            thumbVisibility: true,
            notificationPredicate: (notification) =>
            notification.metrics.axis == Axis.horizontal,
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
                          width: 980,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 500,
                                  child: isEditing == false
                                      ? textfieldCalendar(
                                    context: context,
                                    nameCamp: S
                                        .of(context)
                                        .date,
                                    controllerCamp: controllerSearchSend,
                                  )
                                      : defaultTextfield(
                                      nameCamp: widget.filter == SendFilter.date
                                                ? S.of(context).date
                                                : S.of(context).company,
                                      controllerCamp: controllerSearchSend,
                                      context: context
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0,top: 15.0),
                                  child: SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: isEditing == false
                                      ? GenericDropdown<Sector>(
                                      items:sectorsWithFactories,
                                      camp: S.of(context).sector,
                                      opDefault: S.of(context).allMale,
                                      selectedItem: selectedSector,
                                      hint: S.of(context).sector,
                                      itemLabel: (sector) => sector.name,
                                      onChanged: (sectorChoose) =>
                                          _onSectorChanged(context, sectorChoose),
                                    )
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                                        child: Text(titleSector,
                                          style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,top: 30.0,bottom: 50.0),
                                  child: SizedBox(
                                    child: isEditing == false
                                    ?Consumer<SendFromViewModel>(
                                      builder: (context, vm, _) {
                                        return customDataTable(
                                          key: const ValueKey("new"),
                                          scrollController: verticalScrollTable,

                                          columns: allSectors == false
                                              ? [
                                            S.of(context).company,
                                            S.of(context).observations,
                                            S.of(context).state,
                                            S.of(context).select
                                          ]
                                              : [
                                            S.of(context).company,
                                            S.of(context).sector,
                                            S.of(context).observations,
                                            S.of(context).state,
                                            S.of(context).select
                                          ],

                                          showSectorColumn: allSectors,
                                          lines: vm.controllers,
                                          sendValues: vm.send,
                                          onStateChanged: (index, value) {


                                          },

                                          onSendChanged: (i, value) {
                                            vm.toggleSend(i, value);
                                        },


                                          onSelectedAllChanged: (value) {
                                            for (int i = 0; i <
                                                vm.send.length; i++) {
                                              vm.send[i] = value;
                                            }
                                            vm.notifyListeners();
                                          },

                                          mesage: messageResult,
                                        );
                                      },
                                    )
                                    : Consumer<SendFromViewModel>(
                                           builder: (context, vm, _) {
                                      return customDataTable(
                                      key: const ValueKey("edit"),
                                      scrollController: verticalScrollTable,

                                      columns: allSectors == false
                                      ? [
                                            campKey,
                                            S.of(context).observations,
                                            S.of(context).state,

                                            ]
                                                : [
                                            campKey,
                                            S.of(context).sector,
                                            S.of(context).observations,
                                            S.of(context).state,

                                            ],

                                      showSectorColumn: allSectors,
                                      filter: widget.filter,
                                      lines: vm.controllers,
                                      sendValues: vm.send,
                                      onObservationChanged: (index, value) {

                                        providerLines.updateLines(
                                           vm.controllers[index].id,
                                          observations: value,
                                        );
                                      },

                                      onStateChanged: (index, value) {

                                        providerLines.updateLines(
                                          vm.controllers[index].id,
                                          state: value.name,
                                        );
                                      },

                                      onSendChanged: (i, value) {
                                      vm.toggleSend(i, value);
                                      },


                                      onSelectedAllChanged: (value) {
                                              for (int i = 0; i < vm.send.length; i++)
                                              {
                                                vm.send[i] = value;
                                              }
                                              vm.notifyListeners();
                                      },

                                      mesage: messageResult,
                                      );
                                      },
                                      ),
                                  ),
                                ),
                               const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 550.0),
                                        child: materialButton(
                                          nameAction: action1,
                                          function: () =>isEditing == false
                                                  ? createSend()
                                                  : editSend(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: materialButton(
                                            nameAction: action2,
                                            function: () =>
                                                vm.reset()
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ),
          ),
        )
    ) : Scaffold(
      appBar: appBarAndroid(context, name: "sasd"),
      body: Text("creart email"),
    );
  }

  void _onSectorChanged(BuildContext context, Sector? sectorChoose) {
    if (sectorChoose != null) {
      context.read<SendFromViewModel>()
          .changeSector(sectorChoose.id);
    }
    else {
      if (sectorChoose == null) {
        vm.changeSector("0");
        return;
      }
    }
  }

  Future<void> createSend() async {

    final lines = <LineSend>[];

    final providerLines = context.read<LineSendProvider>();

    final firstId = providerLines.LineSends.isEmpty
        ? 1
        : providerLines.LineSends
        .map((l) => int.parse(l.id))
        .reduce((a, b) => a > b ? a : b) + 1;

    for (int i = 0; i < vm.controllers.length; i++) {

      int id = firstId + i;  //se le va sumando la nueva pos

      if(vm.send[i] == true)
      {
        lines.add(
            LineSend(
              id: id.toString(),
              date: controllerSearchSend.text,
              factory: vm.controllers[i].factory,
              observations: vm.controllers[i].observations.text,
              state: vm.controllers[i].state.name,
            )
        );
      }

    }

    final selectedCount = vm.send
        .where((e) => e)
        .length;
    final result = await providerLines.addLines(lines);

    switch (result) {
      case AddLineResult.success:
        await confirm(
          context,
          LocalizationHelper.sendsDay(context, selectedCount),
        );
        break;

      case AddLineResult.duplicate:
        error(context, S
            .of(context)
            .send_duplicate);
        break;

      case AddLineResult.invalidData:
        await error(context, S
            .of(context)
            .send_invalid_data);
        break;

      case AddLineResult.error:
        error(context, S
            .of(context)
            .send_error);
        break;
    }
    vm.reset();
  }

  Future<void> editSend() async {

    final provaider = context.read<LineSendProvider>();
    int cantSends = provaider.modifiedIds.length;
    final ok = await provaider.saveChanges();

    if(ok)
    {

       await confirm(
         context,
         LocalizationHelper.cantLinesModify(context, cantSends),
       );

    }
    else
    {
       await error(context, S
           .of(context)
           .send_error);
    }

  }
}





