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
    super.initState();
  }


  bool _contains(String text, String search) {
    return text.toLowerCase().contains(search.toLowerCase());
  }

  Future<void> _onFilter(String filter, String search) async {
    final lowerSearch = search.toLowerCase();

    setState(() {
      displayFactories = factoriesSector.where((factory) {

        switch (filter) {

          case 'Name':
          case 'Nombre': // si usas traducciones
            return _contains(factory.name, lowerSearch);

          case 'Address':
          case 'Dirección':
            return _contains(factory.allAdress(), lowerSearch);

          case 'Phone':
          case 'Teléfono':
            return factory.thelephones.isNotEmpty &&
                _contains(factory.thelephones[0], lowerSearch);

          case 'City':
          case 'Ciudad':
            return _contains(factory.address['city']!, lowerSearch);

          default:
            return _contains(factory.name, lowerSearch);
        }
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

  Future<void>_onTap(int index)  async {

        selectCard = index;
     // saveChanges = !await changesNoSave(context);

  }


  @override
  Widget build(BuildContext context0) {

    BuildContext context = Platform.isWindows ? context1 : context0;
    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = mWidth > 280 ? 250 : 0;

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
                    onTap: (factory, index) => _onTap(index),
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
