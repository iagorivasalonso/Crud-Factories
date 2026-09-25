import 'package:crud_factories/Backend/Feature/User/IUserDataSource.dart' show IUserDataSource;
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import '../../../Objects/User.dart';

class SqlUserDataSource implements IUserDataSource {

  final Iexecutequery executeQuery;

  SqlUserDataSource({
    required this.executeQuery,
  });

  @override
  Future<List<User>> load() async {

    final result = await executeQuery.query(
      'SELECT id, username, mail, role, active FROM users'
    );


    return result.map((row) => User(
        id: row['id']?.toString() ?? '',
        username: row['username']?.toString() ?? '',
        mail: row['email']?.toString(),
        role: row['role']?.toString() ?? '',
        active: row['active'] == true || row['active'] == 1,
    )).toList();
  }

  @override
  Future<User> create({
    required User user,
    required String passwordHash,
  }) async {
    await executeQuery.execute(
        'INSERT INTO users (username,password_hash, mail,  role, active) VALUES (?, ?, ?, ?, ?)',
      [
        user.username,
        passwordHash,
        user.mail,
        user.role,
        user.active,
      ],
    );

    return user;
  }

  @override
  Future<User> upload(User user, String passwordHash)  async {

    if(passwordHash.isEmpty)
    {
      await executeQuery.execute(
        '  UPDATE users SET username = ?,mail = ?,role = ?,active = ? WHERE id = ?',
        [
          user.username,
          user.mail,
          user.role,
          user.active,
          user.id,
        ],
      );
    }
    else
    {
      await executeQuery.execute(
        '  UPDATE users SET username = ?,password_hash = ?,mail = ?,role = ?,active = ? WHERE id = ?',
        [
          user.username,
          passwordHash,
          user.mail,
          user.role,
          user.active,
          user.id,
        ],
      );
    }


    return user;
  }

  @override
  Future<void> delete(String id) async {

    await executeQuery.execute(
      'DELETE FROM users WHERE id = ?',
      [id],
    );
  }

  @override
  Future<User?> findByUsernameAndMail(
      String username,
      String mail,
      ) async {
          final result = await executeQuery.query(
            '''
          SELECT id, username, mail, role, active
          FROM users
          WHERE username = ?
            AND mail = ?
            AND active = 1
          LIMIT 1
          ''',
            [username, mail],
          );

          if (result.isEmpty) {
            return null;
          }

          final row = result.first;

          return User(
            id: row['id']?.toString() ?? '',
            username: row['username']?.toString() ?? '',
            mail: row['mail']?.toString(),
            role: row['role']?.toString() ?? '',
            active: row['active'] == true || row['active'] == 1,
          );
  }

}