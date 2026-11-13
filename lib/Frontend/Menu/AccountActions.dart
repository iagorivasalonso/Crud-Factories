import 'package:crud_factories/Alertdialogs/warning.dart';
import 'package:crud_factories/Backend/Providers/App_provaider.dart' show AppProvider;
import 'package:crud_factories/Backend/Providers/FactoryProvider.dart' show FactoryProvider;
import 'package:crud_factories/Backend/Providers/MailProvider.dart' show MailProvider;
import 'package:crud_factories/Backend/Providers/SessionProvider.dart' show SessionProvider;
import 'package:crud_factories/Backend/Providers/UserProvider.dart' show UserProvider;
import 'package:crud_factories/Backend/core/controlsMessagesError/errors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountActions {

  static Future<bool> logout (BuildContext context, String confirmMessage) async {

       final accepted = await warning(context, confirmMessage);

       if(!accepted || !context.mounted){
           return false;
       }
       
       return await finishLogout(context);
  }

  static Future<bool> finishLogout(BuildContext context) async {

    await context.read<SessionProvider>().logout();

    if (!context.mounted) return false;

    await context.read<AppProvider>().logoutToLocal(context);

    if (!context.mounted) return false;

    context.read<FactoryProvider>().select(null);
    context.read<MailProvider>().select(null);
    context.read<UserProvider>().select(null);

    return true;
  }

  static Future<DeleteResult?> deleteAccount (BuildContext context, String stringMessage) async {

      final user = context.read<SessionProvider>().user;

      if (user == null) return null;

      final accepted = await warning(context, stringMessage);

      if (!accepted || !context.mounted) {
        return null;
      }

      final result = await context.read<UserProvider>().delete(user.id);

      if (!context.mounted) return result;

      if (result == DeleteResult.success) {
        await finishLogout(context);
      }

      return result;
  }

  static bool prepareAccountEdit(BuildContext context) {

    final sessionUser = context.read<SessionProvider>().user;

    if (sessionUser == null) return false;

    final userProvider = context.read<UserProvider>();

    final users = userProvider.users;

    final user = users.where(
          (u) => u.id == sessionUser.id,
    );

    if (user.isEmpty) return false;

    userProvider.select(user.first);

    return true;
  }
}