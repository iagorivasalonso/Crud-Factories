import 'package:crud_factories/Alertdialogs/noCategory.dart' show noCategory;
import 'package:crud_factories/Alertdialogs/warning.dart' show warning;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/LineSendProvider.dart' show LineSendProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart';
import 'package:crud_factories/Backend/Providers/SectorProvider.dart';
import 'package:crud_factories/Frontend/Menu/MenuActionsResults.dart';
import 'package:crud_factories/Frontend/adminSectors.dart';
import 'package:crud_factories/generated/l10n.dart' show S;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class MenuActions {

      static Future<bool> canNavigate(BuildContext  context) async {

          return await context
              .read<NavigationProvider>()
                 .canNavigate(context);

      }

      static Future<bool> createFactory(BuildContext context) async {

        if(!await canNavigate(context)) return false;

        return true;
      }

      static Future<bool> createMail(BuildContext context) async  {

        if(!await canNavigate(context)) return false;

        context.read<MailProvider>().select(null);

        return true;

      }

      static Future<MenuActionResult> createShipments(BuildContext context) async  {

          if(!await canNavigate(context))
          {
            return MenuActionResult.cancelled;
          }

          final factories = context.read<FactoryProvider>().factories;

          if(factories.isNotEmpty)
          {
            return MenuActionResult.show;
          }

          final result = await noCategory(
            context,
            S.of(context).companies,
          );

          if (result == 1) {
            return MenuActionResult.create;
          } else if (result == 2) {
            return MenuActionResult.importData;
          }

          return MenuActionResult.cancelled;

      }

      static Future<bool> importData(BuildContext context) async  {

          return await canNavigate(context);
      }

      static Future<void> openSectors(BuildContext context) async {

           if(!await canNavigate(context))
           {
             return;
           }

           final sectors = context.read<SectorProvider>().sectors;

           if(sectors.isEmpty)
           {
               await newSector(context);
           }
           else
           {
               await adminSector(context);
           }

      }

      static Future <MenuActionResult> openFactories(BuildContext context, String? sector) async {

           if( ! await canNavigate(context))
           {
              return MenuActionResult.cancelled;
           }

           final factoriesCurrent = context
               .read<FactoryProvider>()
                  .factoriesBySector(sector);

           if(factoriesCurrent.isNotEmpty)
           {
               return MenuActionResult.show;
           }

           final result = await noCategory(
               context,
               S.of(context).companies,
           );

           if (result == 1) {
               return MenuActionResult.create;
           } else if (result == 2) {
               return MenuActionResult.importData;
           }

             return MenuActionResult.cancelled;

      }

      static Future <MenuActionResult> openMails(BuildContext context) async {

          if( ! await canNavigate(context))
          {
            return MenuActionResult.cancelled;
          }

          final mails = context.read<MailProvider>().mails;

          if(mails.isNotEmpty)
          {
             return MenuActionResult.show;
          }

          final result = await noCategory(
              context,
              S.of(context).mails
          );

          if (result == 1) {
            return MenuActionResult.create;
          } else if (result == 2) {
            return MenuActionResult.importData;
          }

          return MenuActionResult.cancelled;

      }

      static Future <MenuActionResult> openShipments(BuildContext context, String? sectorId) async {

            if( ! await canNavigate(context))
            {
              return MenuActionResult.cancelled;
            }

            final factoryProvider = context.read<FactoryProvider>();
            final lineSendProvider = context.read<LineSendProvider>();

            final sectorHasLines = lineSendProvider.sectorHasLines(
                sectorId: sectorId ?? "0",
                factories: factoryProvider.factories);

            if(!sectorHasLines)
            {
              final result = await noCategory(
                context,
                S.of(context).lines,
              );
              if (result == 1) {
                return MenuActionResult.create;
              } else if (result == 2) {
                return MenuActionResult.importData;
              }
               return MenuActionResult.cancelled;
           }

          return MenuActionResult.show;
      }

      static Future<bool> connectBD(BuildContext context) async {

        if(!await canNavigate(context)) return false;

        final mails =context.read<MailProvider>().mails;

        if (mails.isEmpty) {
          final action = S.of(context).if_you_have_no_registered_addresss_do_you_wish_to_continue;

          final enter = await warning(context, action);

          if (!enter) return false;
        }

        return true;
      }

  static Future<bool> sendMail(BuildContext context) async {

    if(!await canNavigate(context)) return false;

    return true;

  }

}