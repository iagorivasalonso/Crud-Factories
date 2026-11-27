import 'package:crud_factories/Alertdialogs/noCategory.dart' show noCategory;
import 'package:crud_factories/Backend/core/controlsMessagesError/errors.dart' show DeleteResult;
import 'package:crud_factories/Backend/Providers/MailProvider.dart';
import 'package:crud_factories/Backend/Providers/NavigationProvider.dart' show NavigationProvider;
import 'package:crud_factories/Frontend/Menu/MenuActionsResults.dart' show AppView;
import 'package:crud_factories/Frontend/mail.dart';
import 'package:crud_factories/Functions/isNotAndroid.dart';
import 'package:crud_factories/Widgets/defaultCard.dart';
import 'package:crud_factories/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Objects/Mail.dart';
import 'package:crud_factories/Widgets/GenericListViewPage.dart';
import 'package:crud_factories/helpers/localization_helper.dart';
import 'package:provider/provider.dart';

class listMails extends StatefulWidget {

  listMails();

  @override
  State<listMails> createState() => _listMailsState();
}

class _listMailsState extends State<listMails> {

  int selectCard = 0;




Future<bool> _onDelete(BuildContext context,Mail mail) async {

      final confirmDelete = await warning(
          context,
          LocalizationHelper.confirm_delete(
              context,
              mail.mail
          )
     );

      if (!confirmDelete) {
        return false;
      }

      final mailProvider = context.read<MailProvider>();

      //borra email
     final index =  mailProvider.mails.indexWhere(
         (m) => m.id == mail.id
      );

     final result = await mailProvider.delete(mail.id);

      if (result != DeleteResult.success) {
        return false;
      }

      final remaining = context.read<MailProvider>().mails;

      if(remaining.isNotEmpty)
      {
        final newIndex = index < remaining.length
            ? index
            : remaining.length - 1;

        context.read<MailProvider>().select(remaining[newIndex]);

      }
      else
      {
         mailProvider.select(null);
      }

      final mails = context.read<MailProvider>().mails;

      if(mails.isEmpty)
      {
          WidgetsBinding.instance.addPostFrameCallback((_) {

            context.read<NavigationProvider>()
                .go(AppView.home);

            noCategory(context, S.of(context).mails);
          });

      }
      return true;
}

  @override
  Widget build(BuildContext context) {

    final providerMails = context.watch<MailProvider>().mails;

    if (providerMails.isNotEmpty &&
        context.read<MailProvider>().selected == null) {

      WidgetsBinding.instance.addPostFrameCallback((_) {

           if(!mounted) return;
           
           final provider = context.read<MailProvider>();
        
           if(provider.selected == null)
           {
              provider.select(providerMails.first);
           }
      });
    }

    double mWidth = MediaQuery.of(context).size.width;
    double mWidthList = mWidth > 280 ? 250 : 0;
    
    return isNotMobile()
      ? Row(
            children: [
              Container(
                color: Colors.grey,
                width: mWidthList,
                child: _buildList(providerMails: providerMails)
              ),
      
              SizedBox(
                width: mWidth-mWidthList,
                child: context.watch<MailProvider>().selected != null
                       ? MailFormPage()
                       : const SizedBox.shrink(),
              ),
            ],
      )
      : SizedBox(
            width: double.infinity,
            child: _buildList(providerMails: providerMails), 
        );
  }
  
  Widget _buildList({required List<Mail>providerMails}) {
  
       return GenericListViewPage<Mail>(
         itens: providerMails,
         itemBuilder: (mail, index) =>
             defaultCard(
               title: mail.mail,
               description: mail.host.contains('.')
                   ? mail.host.split('.').elementAt(1)
                   : mail.host,
               color: selectCard == index
                   ? Colors.white
                   : Colors.grey,
             ),
         onDelete: (mail) => _onDelete(context, mail),
         onTap: (Mail mail, int index) async {
           if (!await context.read<NavigationProvider>().canNavigate(
               context)) return;

           context.read<MailProvider>().select(mail);
         },
       );
  }
}

