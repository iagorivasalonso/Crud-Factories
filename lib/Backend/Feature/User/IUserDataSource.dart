import 'package:crud_factories/Objects/User.dart' show User;

abstract class IUserDataSource {
  Future<List<User>> load();

  Future<User> create({
    required User user,
    required String passwordHash,
  });


  Future<User> upload(User user, String password);

  Future<void> delete(String id);
}