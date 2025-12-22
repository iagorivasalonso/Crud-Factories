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
import '../../Functions/isNotAndroid.dart';
import '../../Widgets/GenericListViewPage.dart';
import '../../Widgets/factoryCard.dart';
import '../../helpers/localization_helper.dart';


class listFactories extends StatefulWidget {
  BuildContext context;
  List<Factory> list;

  listFactories(this.context, this.list);

  @override
  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {

  late ValueNotifier<List<Factory>> displayFactoriesNotifier;

  int selectIndex = 0;

  int select = 0;

  Factory? factorySelect =null;

  @override
  void initState() {
    super.initState();

    factorySelect = widget.list.isNotEmpty ? widget.list[0] : null;

    // Inicializar el ValueNotifier
    displayFactoriesNotifier = ValueNotifier<List<Factory>>(widget.list);

  }

  void didUpdateWidget(covariant listFactories oldWidget) {
    super.didUpdateWidget(oldWidget);
    displayFactoriesNotifier = ValueNotifier<List<Factory>>(widget.list);
  }

  bool _contains(String text, String search) {
    return text.toLowerCase().contains(search.toLowerCase());
  }

  Future<void> _onFilter(String filter, String search) async {

    final lowerSearch = search.toLowerCase();

    final filtered = (widget.list as List<Factory>).where((factory) {
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

      return _contains(fieldText, lowerSearch);
    }).toList();

    displayFactoriesNotifier.value = filtered;

    if (filtered.isNotEmpty) {
      selectIndex = 0;
    } else {
      selectIndex = -1;
    }
    setState(() {

    });
  }

  Future<bool> _onDelete(BuildContext context, Factory factory) async {
    final confirmDelete = await warning(
      context,
      LocalizationHelper.confirm_delete(context, "${factory.name}"),
    );

    if (confirmDelete) {
      factoriesSector.remove(factory);
      allFactories.remove(factory);

      final updated = List<Factory>.from(widget.list)
        ..remove(factory);

      displayFactoriesNotifier.value = updated;


      return true;
    }

    if (executeQuery != null) {
      await sqlDeleteFactory(factory.id);
    } else {
      csvExportatorFactories(factoriesSector);
    }

    return false;
  }

  Future<void>_onTap(int index, BuildContext context)  async {

    setState(() {
      factorySelect = widget.list[index];
    });


        if (saveChanges) {
          saveChanges = !await changesNoSave(context);
          return;
        }
  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

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
                itens: displayFactoriesNotifier.value,
                filters: filterOptions,
                defaultFilter: S.of(context).name,
                itemBuilder: (factory, index) => factoryCard(
                  name: factory.name,
                  address: factory.allAdress(),
                  telephone: factory.thelephones.isNotEmpty
                      ? factory.thelephones[0]
                      : '',
                  city: factory.address['city'],
                ),
                onFilter: _onFilter,
                onDelete: (factory) => _onDelete(context, factory),
                onTap: (factory, index) => _onTap(index, context),
              ),
            ),

            SizedBox(
              width: mWidth-mWidthList,
              child: newFactory(select,factorySelect),
            ),
          ],
        );


  }
}
