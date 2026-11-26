import 'package:crud_factories/Alertdialogs/confirm.dart';
import 'package:crud_factories/Alertdialogs/error.dart';
import 'package:crud_factories/Backend/Global/viewsModels/SendFrom.dart' show SendFromViewModel;
import 'package:crud_factories/Backend/Providers/EditStateProvider.dart' show EditStateProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/SectorProvider.dart' show SectorProvider;
import 'package:crud_factories/Backend/Providers/filterProvider.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart' show isNotMobile;
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Objects/Sector.dart';
import 'package:crud_factories/Widgets/CustomDataTable.dart';
import 'package:crud_factories/Widgets/headView.dart' show headView;
import 'package:crud_factories/Widgets/headViewsAndroid.dart';
import 'package:crud_factories/Widgets/textfield.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:flutter/material.dart';

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


  bool all_sectors = false;

  String text = "";

  @override
  void initState() {
    super.initState();


    vm = context.read<SendFromViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isEditing = widget.lines.isNotEmpty;

      vm.init(
        isEditing: isEditing,
        lines: widget.lines,
      );

      if (widget.lines.isNotEmpty) {
        text = widget.filter == SendFilter.date
            ? widget.lines.first.date
            : widget.lines.first.factory;

        controllerSearchSend.text = text;

        vm.viewLines(widget.lines, text, widget.filter);
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
            vm.viewLines(widget.lines, text, widget.filter);
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

    final title = isEditing
        ? S.of(context).edit
        : S.of(context).new_male;

    final name = S.of(context).send;
    final title1 = "$title $name";

    String action1 = isEditing
        ? S.of(context).save
        : S.of(context).new_male;

    String action2 = isEditing
        ? S.of(context).undo
        : S.of(context).reboot;

    final providerSectors = context.watch<SectorProvider>().sectors;

    final selectedSector = providerSectors.firstWhereOrNull(
          (s) => s.id == vm.sectorId,
    );


    String messageResult = "";

    String titleSector = "";

    final sectorsWithFactories = providerSectors.where((sector) {
      return context
          .watch<FactoryProvider>()
          .factoriesBySector(sector.id)
          .isNotEmpty;
    }).toList();

    if (isEditing) {

      final sectorId = context.watch<FilterProvider>().sectorId;

      if (sectorId == "0") {
        all_sectors = widget.filter == SendFilter.date
            ? true
            : false;

        titleSector = widget.filter == SendFilter.date
            ? S.of(context).all_sectors
            : S.of(context).list_of_sends;
      }
      else {
        all_sectors = false;

        final sectorSelected = providerSectors.firstWhere(
                (s) => s.id == sectorId
        );

        titleSector = widget.filter == SendFilter.date
            ? '${S.of(context).sector_of} ${sectorSelected.name}'
            : S.of(context).list_of_sends;
      }

      final lines = widget.lines;

      messageResult = widget.filter == SendFilter.date
          ? LocalizationHelper.sendsDay(context, lines.length)
          : LocalizationHelper.sendsDay(context, lines.length);
    }
    else {
      all_sectors = selectedSector == null
          ? true
          : false;


      messageResult = LocalizationHelper.factoriesBD(context, vm.controllers.length);
    }

    return isNotMobile()
        ? Scaffold(
            body: LayoutBuilder(
              builder: (context,constraints) {

                const contentWidth = 980.0;

                final availableWidth = constraints.maxWidth > contentWidth
                    ? constraints.maxWidth
                    : contentWidth;

                return ScrollbarTheme(
                  data: ScrollbarThemeData(
                    thumbColor: WidgetStatePropertyAll(
                      Colors.grey.shade500,
                    ),
                  ),
                  child: Scrollbar(
                    controller: verticalScroll,
                    thumbVisibility: true,
                    thickness: 4,
                    radius: const Radius.circular(4),
                    child: Scrollbar(
                      controller: horizontalScroll,
                      thumbVisibility: true,
                      thickness: 4,
                      radius: const Radius.circular(4),
                      notificationPredicate: (notification) =>
                      notification.metrics.axis == Axis.horizontal,
                      child: SingleChildScrollView(
                        controller: verticalScroll,
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          controller: horizontalScroll,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: availableWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headView(title: title1),
                                  _buildContent(
                                      edit: isEditing,
                                      titleSector: titleSector,
                                      selectedSector: selectedSector,
                                      sectorsWithFactories: sectorsWithFactories,
                                      messageResult: messageResult,
                                      action1: action1,
                                      action2: action2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            )
           ) : Scaffold(
                 appBar: appBarAndroid(context, name: title1),
                 body: ScrollbarTheme(
                     data: ScrollbarThemeData(
                       thumbColor:  WidgetStatePropertyAll(
                          Colors.grey.shade500
                       ),
                     ),
                     child: Scrollbar(
                         controller: verticalScroll,
                         thumbVisibility: true,
                         thickness: 4,
                         radius: const Radius.circular(4),
                         child: SingleChildScrollView(
                             controller: verticalScroll,
                             scrollDirection: Axis.vertical,
                             child: _buildContent(
                               edit: isEditing,
                               titleSector: titleSector,
                               selectedSector: selectedSector,
                               sectorsWithFactories: sectorsWithFactories,
                               messageResult: messageResult,
                               action1: action1,
                               action2: action2,
                             ),
                         )
                     )
                 )
    );
  }

  Widget _buildContent({
      required bool edit,
      required String titleSector,
      required Sector? selectedSector,
      required List <Sector> sectorsWithFactories,
      required String messageResult,
      required String action1,
      required String action2,

       }) {

    return Container(
         constraints: BoxConstraints(
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
                                  child: edit == false
                                      ? textfieldCalendar(
                                            context: context,
                                            nameCamp: S.of(context).date,
                                            controllerCamp: controllerSearchSend,
                                       )
                                      :defaultTextfield(
                                               nameCamp: widget.filter == SendFilter.date
                                                 ? S.of(context).date
                                                 : S.of(context).company,
                                               controllerCamp: controllerSearchSend,
                                               context: context
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 35.0, top: 15.0),
                                  child: SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: edit == false
                                        ? GenericDropdown<Sector>(
                                               items: sectorsWithFactories,
                                               camp: S.of(context).sector,
                                               opDefault: S.of(context).all_male,
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
                                  padding: const EdgeInsets.only(left: 50.0, top: 30.0, bottom: 50.0),
                                  child: isNotMobile()
                                     ? _buildDesktopTable(
                                             editable:edit,
                                             messageResult: messageResult
                                       )
                                     : _buildMobileTable(
                                            editable: edit,
                                            messageResult: messageResult
                                  ),
                                ),

                                const SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 750.0),
                                        child: materialButton(
                                          nameAction: action1,
                                          function: () => _onSaveSend(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0),
                                        child: materialButton(
                                            nameAction: action2,
                                            function: () => _onResetSend()
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  );
}

Widget _buildDesktopTable({
  required bool editable,
  required String messageResult
}) {

  final providerLines = context.read<LineSendProvider>();

  return SizedBox(
          child: editable == false
              ? Consumer<SendFromViewModel>(
            builder: (context, vm, _) {
              return customDataTable(
                key: const ValueKey("new"),
                scrollController: verticalScrollTable,
                isCreateMode: true,
                showSectorColumn: all_sectors,
                lines: vm.controllers,
                sendValues: vm.send,
                onStateChanged: (index, value) {
                  context.read<EditStateProvider>().markChanged();
                },
      
                onSendChanged: (i, value) {
                  context
                      .read<EditStateProvider>()
                      .markChanged();
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
                isCreateMode: false,
                showSectorColumn: all_sectors,
                filter: widget.filter,
                lines: vm.controllers,
                sendValues: vm.send,
                onObservationChanged: (index, value) {
                       context.read<EditStateProvider>().markChanged();

                       providerLines.updateLines(
                                  vm.controllers[index].id,
                                 observations: value,
                       );
                },
      
                onStateChanged: (index, value) {
                      context.read<EditStateProvider>().markChanged();

                      providerLines.updateLines(
                                     vm.controllers[index].id,
                                     state: value.name,
                      );
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
          ),
        );

}

  Widget _buildMobileTable({
    required bool editable,
    required String messageResult
  }) {
     return Text(messageResult);
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

  Future<void> _onSaveSend() async {
    final isEditing = widget.lines.isNotEmpty;
    final providerLines = context.read<LineSendProvider>();

    if (!isEditing) {
      final lines = <LineSend>[];

      final firstId = providerLines.LineSends.isEmpty
          ? 1
          : providerLines.LineSends
          .map((l) => int.parse(l.id))
          .reduce((a, b) => a > b ? a : b) + 1;

      for (int i = 0; i < vm.controllers.length; i++) {
        int id = firstId + i; //se le va sumando la nueva pos

        if (vm.send[i] == true) {
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

      context.read<EditStateProvider>().clear();
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
    else {
      int cantSends = providerLines.modifiedIds.length;
      final ok = await providerLines.saveChanges();

      if (ok) {
        await confirm(
          context,
          LocalizationHelper.cantLinesModify(context, cantSends),
        );
      }
      else {
        await error(context, S
            .of(context)
            .send_error);
      }
    }
    context.read<EditStateProvider>().clear();
  }

  Future<void> _onResetSend() async {
    final isEditing = widget.lines.isNotEmpty;

    if (!isEditing) {
      vm.reset();
    }
    else {
      vm.viewLines(vm.originalLines, text, widget.filter);
    }

    context.read<EditStateProvider>().clear();
  }
}





