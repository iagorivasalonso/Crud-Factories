import 'package:crud_factories/Alertdialogs/error.dart' show error;
import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Providers/EmployeeProvider.dart' show EmployeeProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Backend/Providers/filterProvider.dart' show FilterProvider;
import 'package:crud_factories/Frontend/factory.dart' show FactoryFromPage;
import 'package:crud_factories/Objects/Factory.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Widgets/GenericListViewPage.dart';
import 'package:crud_factories/Widgets/factoryCard.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:crud_factories/Alertdialogs/noCategory.dart';
import 'package:provider/provider.dart';



class listFactories extends StatefulWidget {


  @override
  State<listFactories> createState() => _listFactoriesState();
}

class _listFactoriesState extends State<listFactories> {


  Future<List<Factory>> _onFilter(
      String filter,
      String search,
      ) async {

    final factories = context
        .read<FactoryProvider>()
        .factoriesBySector(
      context.read<FilterProvider>().sectorId,
    );

    if (search.trim().isEmpty) {
      return factories;
    }

    final lowerSearch = search.toLowerCase();

    final filtered = factories.where((factory) {
      final fieldText = switch (filter) {
        var f when f == S.of(context).name =>
        factory.name,

        var f when f == S.of(context).address =>
        factory.address.fullAddress ?? '',

        var f when f == S.of(context).phone =>
        factory.thelephones.isNotEmpty
            ? factory.thelephones.first
            : '',

        var f when f == S.of(context).city =>
        factory.address.city ?? '',

        _ => factory.name,
      };

      return fieldText.toLowerCase().contains(lowerSearch);
    }).toList();

    return filtered;
  }

  Future<bool> _onDelete(BuildContext context, Factory factory) async {

       final confirmDelete = await warning(
           context,
           LocalizationHelper.confirm_delete(
               context,
                factory.name
           )
       );

       if (!confirmDelete) {
         return false;
       }


       final employeeProvider = context.read<EmployeeProvider>();
       final factoryProvider = context.read<FactoryProvider>();

       //Borrado de empleados asociados
        await employeeProvider.removeFactoryEmployees(
           factory.id
        );

        //borra la empresa

        final index = factoryProvider.factories.indexWhere(
            (f) => f.id == factory.id
        );

        final result = await factoryProvider.delete(factory.id);

         if (result != DeleteResult.success) {
           return false;
         }

         final remaining = factoryProvider.factoriesBySector(
               context.read<FilterProvider>().sectorId,
         );

       if (remaining.isNotEmpty) {
         final newIndex = index < remaining.length
             ? index
             : remaining.length - 1;

         factoryProvider.select(
           remaining[newIndex],
         );
       }
       else
       {
         factoryProvider.select(null);
       }

       final sectorId = context.read<FilterProvider>().sectorId;
       final factoriesCurrent= context.read<FactoryProvider>().factoriesBySector(sectorId);

       if(factoriesCurrent.isEmpty)
       {
         WidgetsBinding.instance.addPostFrameCallback((_) {

           context.read<NavigationProvider>()
               .go(AppView.home);

           if (sectorId=="0") {
             noCategory(context, S.of(context).companies);
           } else {
             error(context, S.of(context).it_does_not_have_companies_in_this_sector);
           }

         });
       }
        return true;
  }


  @override
  Widget build(BuildContext context) {

    final sectorId = context.watch<FilterProvider>().sectorId;
    final providerFactories = context.watch<FactoryProvider>().factoriesBySector(sectorId);

    if (providerFactories.isNotEmpty &&
        context.read<FactoryProvider>().selected == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<FactoryProvider>().select(
              providerFactories.first,
            );
          });
    }

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
            SizedBox(
              width: mWidthList,
              child: GenericListViewPage<Factory>(
                itens: providerFactories,
                filters: filterOptions,
                defaultFilter: S.of(context).name,
                itemBuilder: (factory, index) => factoryCard(
                  name: factory.name,
                  address: factory.address?.fullAddress ?? '',
                  telephone: (factory.thelephones.isNotEmpty == true)
                      ? factory.thelephones.first
                      : '',
                  city: factory.address?.city ?? '',
                ),
                onFilter: _onFilter,
                onDelete: (factory) => _onDelete(context, factory),
                onTap: (factory, index) async {
                  context.read<FactoryProvider>().select(factory);
                },
              ),
            ),

            SizedBox(
              width: mWidth-mWidthList,
              child: context.watch<FactoryProvider>().selected != null
                  ? FactoryFromPage()
                  : Text(""),
            ),
          ],
        );
  }
}
