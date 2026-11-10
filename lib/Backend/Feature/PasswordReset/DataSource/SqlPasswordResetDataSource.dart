
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart' show Iexecutequery;
import 'package:crud_factories/Backend/Feature/PasswordReset/DataSource/IPasswordResetDataSource.dart' show IPasswordResetDataSource;

import '../../Connection/ExecuteQuery/ITransacionalExecuteQuery.dart';

class SqlPasswordResetDataSource implements IPasswordResetDataSource {

  final Iexecutequery executeQuery;
  final ITransactionalExecuteQuery transactionalExecuteQuery;

  SqlPasswordResetDataSource({
    required this.executeQuery,
    required this.transactionalExecuteQuery,
  });

  @override
  Future<void> completeReset({
    required int resetId,
    required int userId,
    required String tokenHash,
    required String passwordHash,
  }) async {
    await transactionalExecuteQuery.transaction((executor) async {

      final result = await executor.query(
        '''
      SELECT id
      FROM password_resets
      WHERE id = ?
        AND user_id = ?
        AND token_hash = ?
        AND used = 0
        AND expires_at > UTC_TIMESTAMP()
      FOR UPDATE
      ''',
        [resetId, userId, tokenHash],
      );

      if (result.isEmpty) {
        throw Exception('La solicitud de recuperación ya no es válida');
      }

      await executor.execute(
        '''
      UPDATE users
      SET password_hash = ?
      WHERE id = ?
      ''',
        [passwordHash, userId],
      );

      await executor.execute(
        '''
      UPDATE password_resets
      SET used = 1
      WHERE id = ? AND user_id = ? AND used = 0
      ''',
        [resetId, userId],
      );
    });
  }

  @override
  Future<int?> findActiveUserId({
    required String username,
    required String mail,
  }) async {
    final result = await executeQuery.query(
      '''
      SELECT id
      FROM users
      WHERE username = ? AND mail = ? AND active = 1
      LIMIT 1
      ''',
      [username, mail],
    );

    if (result.isEmpty) return null;

    return (result.first['id'] as num).toInt();
  }

  @override
  Future<Map<String, dynamic>?> findLatestReset({
    required String username,
    required String mail,
  }) async {
    final result = await executeQuery.query(
      '''
      SELECT pr.id, pr.user_id, pr.token_hash, pr.expires_at,
             pr.used, pr.attempts
      FROM password_resets pr
      INNER JOIN users u ON u.id = pr.user_id
      WHERE u.username = ? AND u.mail = ? AND u.active = 1
      ORDER BY pr.id DESC
      LIMIT 1
      ''',
      [username, mail],
    );

    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  Future<void> invalidatePending(int userId) async {
    await executeQuery.execute(
      '''
      UPDATE password_resets
      SET used = 1
      WHERE user_id = ? AND used = 0
      ''',
      [userId],
    );
  }

  @override
  Future<void> registerFailedAttempt({
    required int resetId,
  }) async {
    await executeQuery.execute(
      '''
    UPDATE password_resets
    SET attempts = attempts + 1,
        used = CASE WHEN attempts + 1 >= 5 THEN 1 ELSE used END
    WHERE id = ? AND used = 0
    ''',
      [resetId],
    );
  }

  @override
  Future<void> saveReset({
    required int userId,
    required String tokenHash,
    required DateTime expiresAt,
  }) async {
    await executeQuery.execute(
      '''
      INSERT INTO password_resets (user_id, token_hash, expires_at)
      VALUES (?, ?, ?)
      ''',
      [userId, tokenHash, expiresAt],
    );
  }
}
