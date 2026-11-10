abstract class IPasswordResetDataSource {

  Future<int?> findActiveUserId({
    required String username,
    required String mail,
  });

  Future<void> invalidatePending(int userId);

  Future<void> saveReset({
    required int userId,
    required String tokenHash,
    required DateTime expiresAt,
  });

  Future<Map<String, dynamic>?> findLatestReset({
    required String username,
    required String mail,
  });

  Future<void> registerFailedAttempt({
    required int resetId,
  });

  Future<void> completeReset({
    required int resetId,
    required int userId,
    required String tokenHash,
    required String passwordHash,
  });
}