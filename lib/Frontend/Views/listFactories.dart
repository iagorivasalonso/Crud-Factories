import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/CSV/exportEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/exportFactories.dart';
import 'package:crud_factories/Backend/Global/list.dart';
import 'package:crud_factories/Backend/Global/variables.dart';
import 'package:crud_factories/Frontend/factory.dart' show newFactory;
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/SQL/deleteFactory.dart';
import 'package:crud_factories/Functions/changesNoSave.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/GenericListViewPage.dart';
import 'package:crud_factories/Widgets/factoryCard.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';



class listFactories extends StatefulWidget {
  BuildContext context;
  List<Factory> list;
  String sector; //esto es lo q necesito para la condicion

  listFactories(this.context, this.list, this.sector);

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


    if (oldWidget.sector != widget.sector) {
      displayFactoriesNotifier.value = List.from(widget.list);

      if (widget.list.isNotEmpty) {
        factorySelect = widget.list.first;
        selectIndex = 0;
      } else {
        factorySelect = null;
        selectIndex = -1;
      }
    }
  }

  bool _contains(String text, String search) {
    return text.toLowerCase().contains(search.toLowerCase());
  }

  Future<void> _onFilter(String filter, String search) async {

    final lowerSearch = search.toLowerCase();

    final filtered = widget.list.where((factory) {
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
      empleoyes.removeWhere((f) => f.idFactory == factory.id);
      factoriesSector.remove(factory);
      allFactories.remove(factory);


      if (BaseDateSelected.isNotEmpty) {
        await sqlDeleteFactory(factory.id);
      } else {
        csvExportatorEmpleoyes(empleoyes);
        csvExportatorFactories(allFactories);
      }


      final updated = List<Factory>.from(displayFactoriesNotifier.value)
        ..remove(factory);

      displayFactoriesNotifier.value = updated;

      setState(() {
        if (displayFactoriesNotifier.value.isNotEmpty) {
          factorySelect = displayFactoriesNotifier.value.first;
          selectIndex = 0;
        } else {
          factorySelect = null;
          selectIndex = -1;
        }
      });

      if (displayFactoriesNotifier.value.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          String array = S.of(context).companies;
          noCategory(context, array);
        });
        return true;
      }
    }

    return false;
  }

  Future<void> _onTap(int index, BuildContext context) async {

    if (saveChanges) {
      bool discard = await changesNoSave(context);

      if (!discard) return;

      saveChanges = false;
    }

    setState(() {
      factorySelect = displayFactoriesNotifier.value[index];
      selectIndex = index; // opcional pero recomendable
    });

  }

  @override
  Widget build(BuildContext context0) {

    BuildContext context = isNotAndroid() ? context0 :  context1;

    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = mWidth > 280 ? 260 : 0;


    final filterOptions = [
      S.of(context).name,
      S.of(context).address,
      S.of(context).phone,
      S.of(context).city,
    ];



    return Row(
          children: [
            if(factorySelect != null)
            SizedBox(
              width: mWidthList,
              child: ValueListenableBuilder<List<Factory>>(
                  valueListenable: displayFactoriesNotifier,
                    builder: (context0, list, _) {

                      return GenericListViewPage<Factory>(
                        itens: list,
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
                      );
                    },
                  ),
            ),

            SizedBox(
              width: mWidth-mWidthList,
              child: factorySelect != null
                  ? newFactory(select, factorySelect)
                  : Text(""),
            ),
          ],
        );
  }
}
