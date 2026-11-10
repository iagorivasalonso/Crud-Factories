
import 'dart:math';
import 'dart:convert';
import 'package:crud_factories/Backend/core/service/PasswordService.dart';
import 'package:crud_factories/Objects/MailMessage.dart' show MailMessage;
import 'package:crypto/crypto.dart';

import 'package:crud_factories/Backend/Feature/PasswordReset/DataSource/IPasswordResetDataSource.dart';
import 'package:crud_factories/Backend/Feature/PasswordReset/Service/IPasswordResetService.dart';
import 'package:crud_factories/Backend/Providers/MailProvider.dart';

class SqlPasswordResetService implements IPasswordResetService {

  final IPasswordResetDataSource dataSource;
  final MailProvider mailProvider;
  final String Function(String username, String token) messageBuilder;
  final String subject;

  SqlPasswordResetService({
    required this.dataSource,
    required this.mailProvider,
    required this.messageBuilder,
    required this.subject,
   });

  static const int maxAttempts = 5;
  static const int resetMinutes = 10;

  String _generateToken () {

       final random = Random.secure();

       return List.generate(
           32,
           (_) => random.nextInt(256).toRadixString(16).padLeft(2,'0'),

       ).join();
  }

  String _hashToken(String token) {

    return sha256.convert(utf8.encode(token)).toString();

  }

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;

    var difference = 0;

    for (var i = 0; i < a.length; i++) {
      difference |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }

    return difference == 0;
  }
  @override
  Future<void> requestReset({required String username, required String mail}) async {

    print('Username: "$username"');
    print('Mail: "$mail"');

    final userId = await dataSource.findActiveUserId(
            username: username,
            mail: mail
        );

        if (userId == null) {
          throw Exception('Usuario o correo no válido');
        }

        final token = _generateToken();

        await dataSource.invalidatePending(userId);

        await dataSource.saveReset(
            userId: userId,
            tokenHash: _hashToken(token),
            expiresAt: DateTime.now().toUtc().add(
                const Duration(minutes: resetMinutes),
            ),
        );

    print('UserId encontrado: $userId');
        try {
              final systemMails = await mailProvider.loadSystemMails();


              if (systemMails.isEmpty) {
                throw Exception('No hay cuentas SMTP disponibles');
              }

              final result = await mailProvider.send(
                MailMessage(
                  recipients: [mail],
                  subject: subject,
                  message: messageBuilder(username, token),
                ),
                account: systemMails.first,
                noAccountMessage: 'No hay una cuenta SMTP disponible',
              );


              if (!result.success || result.failed.isNotEmpty) {
                throw Exception('No se pudo enviar el correo de recuperación');
              }

        } catch(_){
          try {
            await dataSource.invalidatePending(userId);
          } catch (_) {
            // No ocultar el error original del envío.
          }

          rethrow;
        }

  }

  @override
  Future<void> resetPassword({required String username, required String mail, required String token, required String newPassword}) async {

        final valid = await verifyReset(
            username: username,
            mail: mail,
            token: token
        );

        if (!valid) {
          throw Exception('El código de recuperación no es válido');
        }

        final reset = await dataSource.findLatestReset(
            username: username,
            mail: mail
        );

        if (reset == null) {
          throw Exception('No existe una recuperación pendiente');
        }

        final userId = (reset['user_id'] as num).toInt();
        final resetId = (reset['id'] as num).toInt();

        final passwordHash = PasswordService.hash(newPassword);

        await dataSource.completeReset(
            resetId: resetId,
            userId: userId,
            passwordHash: passwordHash,
            tokenHash: _hashToken(token)
        );
  }

  @override
  Future<bool> verifyReset({required String username, required String mail, required String token}) async {

         final reset = await dataSource.findLatestReset(
             username: username,
             mail: mail
         );

         if(reset == null) return false;

         final used = reset['used'] == true ||  reset['used'] == 1;

         final attempts = (reset['attempts'] as num).toInt();

         if (used || attempts >= maxAttempts) return false;

         final expiresAt = reset['expires_at'] is DateTime
             ? reset['expires_at'] as DateTime
             : DateTime.parse(reset['expires_at'].toString());

         if (!expiresAt.toUtc().isAfter(DateTime.now().toUtc())) {
           return false;
         }

         final expectedHash = reset['token_hash'] as String;
         final receivedHash = _hashToken(token);

         if (!_constantTimeEquals(expectedHash, receivedHash)) {
           await dataSource.registerFailedAttempt(
             resetId: (reset['id'] as num).toInt(),
           );

               return false;
         }

        return true;
  }
}