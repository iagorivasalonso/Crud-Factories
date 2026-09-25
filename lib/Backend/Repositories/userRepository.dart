import 'package:crud_factories/Backend/Feature/User/IUserDataSource.dart';
import 'package:crud_factories/Backend/core/service/PasswordService.dart';


import '../../Objects/User.dart';

class UserRepository {
  final IUserDataSource dataSource;

  UserRepository({
    required this.dataSource,
  });

  Future<List<User>> load() async {
    return await dataSource.load();
  }

  Future<List<String>> loadAdminRecipients() async {
    final users = await dataSource.load();

    return users
        .where((user) =>
        user.role == 'admin' &&
        user.active &&
        user.mail != null &&
        user.mail!.trim().isNotEmpty)
        .map((user) => user.mail!.trim())
        .toList();
  }

  Future<User> create(User user,  String password) async {

      final passwordHash = PasswordService.hash(password); // password;

    return await dataSource.create(user: user, passwordHash: passwordHash);
  }

  Future<User> upload(User user,String password) async {

      if(password.isNotEmpty)
      {
        final passwordHash = PasswordService.hash(password); // password;
        return await dataSource.upload(user,passwordHash);
      }
      // No cambiar password
      return await dataSource.upload(user, "");
  }

  Future<void> delete(String id) async {
    await dataSource.delete(id);
  }

  Future<User?> findByUsernameAndMail(
      String username,
      String mail,
      ) async {
    return await dataSource.findByUsernameAndMail(
      username,
      mail,
    );
  }


}