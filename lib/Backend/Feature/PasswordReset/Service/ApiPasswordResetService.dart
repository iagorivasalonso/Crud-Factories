import 'package:crud_factories/Backend/Feature/PasswordReset/DataSource/IApiPasswordResetDataSource.dart';
import 'package:crud_factories/Backend/Feature/PasswordReset/Service/IPasswordResetService.dart';

class ApiPasswordResetService  implements IPasswordResetService {

  final IApiPasswordResetDataSource dataSource;

  ApiPasswordResetService ({
      required this.dataSource,
  });

  @override
  Future<void> requestReset({required String username, required String mail}) async{

      await dataSource.requestReset(
          username: username,
          mail: mail
      );
  }

  @override
  Future<void> resetPassword({
    required String username,
    required String mail,
    required String token,
    required String newPassword}) async  {

      await dataSource.resetPassword(
          username: username,
          mail: mail,
          token: token,
          newPassword: newPassword
      );
  }

  @override
  Future<bool> verifyReset({required String username, required String mail, required String token}) async {

     return dataSource.verifyReset(
          username: username,
          mail: mail,
          token: token
      );
  }

}