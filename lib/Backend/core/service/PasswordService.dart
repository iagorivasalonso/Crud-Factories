import 'package:bcrypt/bcrypt.dart' show BCrypt;

class PasswordService {

 static String hash(String password) {

    return BCrypt.hashpw(
      password,
      BCrypt.gensalt(logRounds: 10),
    );
  }

  bool verify(
      String password,
      String passwordHash,
      ) {
    return BCrypt.checkpw(
      password,
      passwordHash,
    );
  }
}