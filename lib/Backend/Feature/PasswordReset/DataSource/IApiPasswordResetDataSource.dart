abstract class IApiPasswordResetDataSource {

  Future<void> requestReset({
    required String username,
    required String mail,
  });

  Future<bool> verifyReset({
    required String username,
    required String mail,
    required String token,
  });

  Future<void> resetPassword({
    required String username,
    required String mail,
    required String token,
    required String newPassword,
  });
}