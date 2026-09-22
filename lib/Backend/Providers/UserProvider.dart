import 'package:crud_factories/Backend/Data/controlsMessagesError/errors.dart';
import 'package:crud_factories/Backend/Repositories/userRepository.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../../Functions/createId.dart';
import '../../Objects/User.dart';

enum UserRole {
  admin,
  user,
}

class UserProvider  extends ChangeNotifier {

  UserRepository? repository;

  List<User> _users = [];

  List<User> get users => _users;

  User? selected;

  // =========================
  //  SETREPO
  // =========================

  void setRepo(UserRepository repository) {
      this.repository = repository;
  }

  // =========================
  //  GETREPO
  // =========================

  UserRepository get _repo {
    final r = repository;
    if (r == null) {
      throw Exception("Repository not initialized");
    }
    return r;
  }
  // =========================
  //  EXISTS
  // =========================

  bool exist(String user, {String? exclude}) {
    final userLower = user.toLowerCase();

    return _users.any((m) {
      final userName = m.username.toLowerCase();

      if (exclude != null && userName == exclude.toLowerCase()) {
        return false;
      }

      return userName == userLower;
    });
  }
  // =========================
  // LOAD
  // =========================

  Future<void> load() async {

    if (repository == null) return;

    _users = await repository!.load();

    notifyListeners();
  }

  // =========================
  // SELECT
  // =========================

  void select(User? u) {

    selected = u;
    notifyListeners();
  }


  // =========================
  //  RELOAD REPO
  // =========================

  Future<void> setRepositoryAndReload( UserRepository repository) async {

     this.repository = repository;
     await load();
  }

  // =========================
  //  CREATE
  // =========================

  Future<CreateResult> create(
      User user,
      String password,
      ) async {

    final username = user.username.trim();

    if (username.isEmpty) {
      return CreateResult.invalidData;
    }

    final exits = exist(username);

    if (exits) {
      return CreateResult.alreadyExists;
    }

    final idNew = users.isNotEmpty
        ? createId(users.last.id)
        : "1";

   final newUser = User(
       id: idNew,
       username: user.username,
       mail: user.mail,
       role: user.role,
       active: user.active
   );

    _users.add(newUser);
    notifyListeners();
    await _repo.create(user, password);

    return CreateResult.success;


  }

  // =========================
  //  UPDATE
  // =========================

  Future<EditResult> update(User update, String password) async {

    if(update.username.trim().isEmpty) {
      return EditResult.invalidData;
    }

    final user = update.username.trim();

    final index = _users.indexWhere((m) => m.id == update.id);
    if (index == -1) {
      return EditResult.notFound;
    }


    final oldUser = _users[index];

    if(exist(user,exclude: oldUser.username)) {
      return EditResult.alreadyExists;
    }

    final newUser = User(
        id: update.id,
        username: update.username,
        mail: update.mail,
        role: update.role,
        active: update.active
    );

    _users[index] = newUser;
    notifyListeners();

    await _repo.upload(newUser,password);
    return EditResult.success;


  }


  // =========================
  //  DELETE
  // =========================

  Future<DeleteResult> delete(String id) async {

    final index = _users.indexWhere((u) => u.id == id);

    if (index == -1) {
      return DeleteResult.notFound;
    }

    final removed = _users[index];

    _users.removeAt(index);
    notifyListeners();

    try {
      await _repo.delete(id);
      return DeleteResult.success;
    } catch (e) {
      // rollback
      _users.insert(index, removed);
      notifyListeners();
      return DeleteResult.notFound;
    }
  }

  // =========================
  //  CLEAR
  // =========================

  void clear() {
    _users.clear();
    repository = null;

    notifyListeners();
  }

}