import 'package:crud_factories/Alertdialogs/noCategory.dart' show noCategory;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart' show DeleteResult;
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart' show NavigationProvider, AppView;
import 'package:crud_factories/Frontend/send.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/CSV/exportLines.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/SQL/deleteLines.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Functions/manageArrays.dart';
import 'package:crud_factories/Objects/LineSend.dart';
import 'package:crud_factories/Widgets/GenericListViewPage.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../../Backend/Providers/FactoryProvider.dart';
import '../../Backend/Providers/filterProvider.dart';

class listSends extends StatefulWidget {


  listSends();

  @override
  State<listSends> createState() => _listSendsState();
}

class _listSendsState extends State<listSends> {


  int selectCard = 0;
  String selectCamp = "";
  List<LineSend> selectedLines = [];

  @override
  void initState() {
    super.initState();

        final providerLines = context.read<LineSendProvider>();
        final sectorId = context.read<FilterProvider>().sectorId;
        final displayLines = providerLines.displayLines(sectorId: sectorId);

        if(displayLines.isNotEmpty)
        {
           _selectSend(providerLines, 0, displayLines.first);
        }

  }


   void _onTap(BuildContext context, int index, cardSend send) async {

     final providerLines = context.read<LineSendProvider>();

     _selectSend(providerLines, index, send);

     if (selectedLines.isEmpty) {
       await noCategory(context, S.of(context).lines);
       return;
     }
   }

   void _selectSend (LineSendProvider current, int index, cardSend send) {

     final sectorId = context.read<FilterProvider>().sectorId;

     setState(() {
       selectCard = index;
       selectCamp = current.selectedFilter == SendFilter.date
           ? send.description
           : send.title;

       selectedLines = current.getLines(sectorId: sectorId,
         date: current.selectedFilter == SendFilter.date
             ? send.description
             : null,
         factory: current.selectedFilter == SendFilter.company
             ? send.title
             : null,
       );
     });
   }
  Future<List<cardSend>> _sendFilter(String filter, String search) async {
    final sectorId = context.watch<FilterProvider>().sectorId;
    final provider = context.read<LineSendProvider>();

    provider.changeFilter(
      filter == S.of(context).date
          ? SendFilter.date
          : SendFilter.company,
    );

    return provider.searchCards(
        search,
      sectorId: sectorId,
    );
  }

  Future <bool>_onDelete(BuildContext context, send) async {

    final lineProvider = context.read<LineSendProvider>();
    final filter = lineProvider.selectedFilter;
    final sectorId = context.watch<FilterProvider>().sectorId;

    final confirmDelete = await warning(
        context,
        LocalizationHelper.confirm_delete(
          context,
          S.of(context).You_can_only_delete_the_lines_that_were_returned_Do_you_want_to_delete,
        ),
    );
    if(!confirmDelete) return false;


    final result = await lineProvider.removeReturned(
       factory: filter == SendFilter.company ? send.title : null,
       date: filter == SendFilter.date ? send.description : null,
    );

    if (result == DeleteResult.success) {
      final filter = lineProvider.selectedFilter;

      setState(() {
        selectedLines = lineProvider.getLines(
          sectorId: sectorId,
          date: filter == SendFilter.date ? send.description : null,
          factory: filter == SendFilter.company ? send.title : null,
        );

        if (selectedLines.isEmpty) {
          selectCard = -1;
          selectCamp = "";
        }
      });
    }

    if (result != DeleteResult.success) {
      return false;
    }
    final providerLines = context.read<LineSendProvider>();
    final displayLines = providerLines.displayLines(sectorId: "0");

    if (displayLines.isEmpty) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<NavigationProvider>().go(AppView.home);
        });
      }

    }

     return true;
  }

  @override
  Widget build(BuildContext context) {


    final providerLines = context.watch<LineSendProvider>();
    final sectorId = context.watch<FilterProvider>().sectorId;

    

    double mWidth = MediaQuery.of(context).size.width;
    final mWidthList = mWidth >= 280 ? 280.0 : 0.0;

    final filterOptions = [
      S.of(context).date,
      S.of(context).company,
    ];



      return Row(
        children: [
            Container(
              color: Colors.grey,
              width: mWidthList,
              child: GenericListViewPage<cardSend>(
                  itens: providerLines.displayLines(
                     shipmentText: S.of(context).shipment,
                    sectorId: sectorId,
                  ),
                  filters: filterOptions,
                  defaultFilter: providerLines.selectedFilter == SendFilter.date
                              ? S.of(context).date
                              : S.of(context).company,
                  itemBuilder: (send, index) => defaultCard(
                      title: send.title,
                      description: providerLines.selectedFilter == SendFilter.date
                          ? LineSend.showFormatDate(send.description, context)
                          : send.description,
                      color: selectCard == index? Colors.white : Colors.grey),
                  onDelete: (send) =>_onDelete(context,send),
                  onTap: (send, index) async => _onTap(context, index, send),
                  
                  onFilter: (filter, search) async => _sendFilter(filter,sectorId),
            )
            ),
          Expanded(
            child: selectedLines.isEmpty
                ? const SizedBox()
                : SendFromPage(
                     lines: selectedLines,
                     filter:  providerLines.selectedFilter,
                     selectCamp:  selectCamp,
                     select: 0,
                  ),
          ),
        ],
      );
    }
    

}


