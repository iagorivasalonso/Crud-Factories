import 'package:bcrypt/bcrypt.dart';
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart';
import 'package:crud_factories/Backend/Feature/Session/ISessionService.dart';
import 'package:crud_factories/Backend/Providers/ConectionProvider.dart' show ConnectionProvider;
import 'package:crud_factories/Objects/AppSession.dart' show AppSession;
import 'package:uuid/uuid.dart';
import '../../../Objects/User.dart';

class SqlSessionService implements ISessionservice{


  final ConnectionProvider connectionProvider;

  SqlSessionService({
    required this.connectionProvider,
  });


  Iexecutequery get executeQuery {
    final query = connectionProvider.executeQuery;

    if (query == null) {
      throw Exception(
        'No hay conexión a la base de datos',
      );
    }

    return query;
  }

  @override
  Future<SessionResult> login(String username, String password) async {


    final rowsUsers = await executeQuery.query(
      '''
    SELECT id, username, password_hash, role, active
    FROM users
    WHERE username = ?
    LIMIT 1
    ''',
      [username],
    );

    if (rowsUsers.isEmpty) {
      throw Exception('Usuario o contraseña incorrectos');
    }

    final userData = rowsUsers.first;

    // 1. Comprobar contraseña
    final passwordHash = userData['password_hash'].toString();

    final passwordValid = BCrypt.checkpw(
      password,
      passwordHash,
    );

    if (!passwordValid) {
      throw Exception('Usuario o contraseña incorrectos');
    }

    // 2. Usuario válido
    final user = User.fromMap(userData);

    // 3. Crear sesión
    final sessionId = const Uuid().v4();
    final userId = user.id;

    final createdAt = DateTime.now();
    final expiresAt = createdAt.add(
      const Duration(hours: 24),
    );

    await executeQuery.execute(
      '''
    INSERT INTO sessions (
      id,
      user_id,
      created_at,
      expires_at
    )
    VALUES (?, ?, ?, ?)
    ''',
      [
        sessionId,
        userId,
        createdAt,
        expiresAt,
      ],
    );

    // 4. Crear AppSession directamente
    final session = AppSession(
      id: sessionId,
      userId: userId,
      createdAt: createdAt,
      expiresAt: expiresAt,
    );

    return SessionResult(
      user: user,
      session: session,
    );
  }

  @override
  Future<void> logout(String sessionId) async {

    await executeQuery.execute(
      '''
    DELETE FROM sessions
    WHERE id = ?
    ''',
      [sessionId],
    );
  }

  @override
  Future<SessionResult?> restoreSession(String sessionId) async{


    // 1. Buscar la sesión
    final sessionRows = await executeQuery.query(
      '''
    SELECT id, user_id, created_at, expires_at
    FROM sessions
    WHERE id = ?
    LIMIT 1
    ''',
      [sessionId],
    );

    // 2. La sesión no existe
    if (sessionRows.isEmpty) {
      return null;
    }

    final sessionData = sessionRows.first;

    // 3. Convertir los datos a AppSession
    final session = AppSession.fromMap(sessionData);

    // 4. Comprobar si ha caducado
    if (session.isExpired) {
      await logout(sessionId);
      return null;
    }

    // 5. Buscar el usuario de esa sesión
    final userRows = await executeQuery.query(
      '''
    SELECT id, username, role, active
    FROM users
    WHERE id = ?
    LIMIT 1
    ''',
      [session.userId],
    );

    // 6. El usuario ya no existe
    if (userRows.isEmpty) {
      await logout(sessionId);
      return null;
    }

    // 7. Crear User
    final user = User.fromMap(userRows.first);

    if (!user.active) {
      await logout(sessionId);
      return null;
    }
    // 8. Devolver sesión restaurada
    return SessionResult(
      user: user,
      session: session,
    );
  }
}