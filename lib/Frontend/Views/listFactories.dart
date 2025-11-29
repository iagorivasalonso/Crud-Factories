import 'dart:io';

import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/factory.dart' show newFactory;
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import '../../Alertdialogs/warning.dart';
import '../../Backend/CSV/exportFactories.dart';
import '../../Backend/SQL/deleteFactory.dart';
import '../../Functions/changesNoSave.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../Widgets/factoryCard.dart';
import '../../helpers/localization_helper.dart';

class listFactories extends StatefulWidget {

  BuildContext context;
  bool err;

  listFactories(this.context, this.err);


  @override
  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {

  late List<Factory> displayFactories;
  int selectCard = -1;

  @override
  void initState() {
    displayFactories = List.from(factoriesSector);
    if (displayFactories.isNotEmpty) {
      selectCard = 0;
    }
    super.initState();
  }


  bool _contains(String text, String search) {
    return text.toLowerCase().contains(search.toLowerCase());
  }

  Future<void> _onFilter(String filter, String search) async {
    final lowerSearch = search.toLowerCase();

    setState(() {
      displayFactories = factoriesSector.where((factory) {

        final filterMap = {
          'Name': factory.name,
          'Nombre': factory.name,

          'Address': factory.allAdress(),
          'Dirección': factory.allAdress(),

          'Phone': factory.thelephones.isNotEmpty ? factory.thelephones[0] : '',
          'Teléfono': factory.thelephones.isNotEmpty ? factory.thelephones[0] : '',

          'City': factory.address['city'] ?? '',
          'Ciudad': factory.address['city'] ?? '',
        };

        final fieldText = filterMap[filter] ?? factory.name;

        // Aplicar el contains seguro
        return _contains(fieldText, lowerSearch);

      }).toList();
    });
  }



  Future<void>_onDelete(Factory factory)  async {

    final confirmDelete = await warning(
      context,
      LocalizationHelper.delete_factory(context, factory.name),
    );

    if (confirmDelete) {
      setState(() {
        factoriesSector.remove(factory);
        allFactories.remove(factory);
      });

      if (conn != null) {
        await sqlDeleteFactory(factory.id);
      } else {
        csvExportatorFactories(factoriesSector);
      }
    }

  }

  Future<void>_onTap(int index, BuildContext context)  async {

        selectCard = index;

        if (saveChanges) {
          saveChanges = !await changesNoSave(context);
          return;
        }
  }


  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;
    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = mWidth > 280 ? 250 : 0;
    print("cambios ~$saveChanges");
    final filterOptions = [
      S.of(context).name,
      S.of(context).address,
      S.of(context).phone,
      S.of(context).city,
    ];

    return Row(
      children: [
            SizedBox(
              width: mWidthList,
              child: GenericListViewPage<Factory>(
                     itens: displayFactories,
                     filters: filterOptions,
                     defaultFilter: S.of(context).name,
                     itemBuilder: (factory, index) => factoryCard(
                        name: factory.name,
                        address: factory.allAdress(),
                        telephone: factory.thelephones.isNotEmpty ? factory.thelephones[0] : '',
                        city: factory.address['city'],
                    ),
                    onFilter: _onFilter,
                    onDelete: _onDelete,
                    onTap: (factory, index) => _onTap(index,context),
                    onSelect: (index) {
                      setState(() {
                       // selectedIndex = index;
                      });
                },
              ),
            ),

          SizedBox(
            width: mWidth-mWidthList,
            child: newFactory(selectCard),
          ),
      ],
    );
  }


}
