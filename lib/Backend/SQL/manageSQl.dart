
import 'package:mysql1/src/single_connection.dart';


class actionsBD {

  static Future<bool> createDB(String nameBD, conn) async {

    try {

      await conn.query('CREATE DATABASE $nameBD');
      await conn.query('USE `$nameBD`');

      return true;

    }catch(_){
      return false;
    }

  }

  static Future<bool> createTables(MySqlConnection conn) async {
    try {
      // =========================
      // USERS
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS users (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(100) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        role VARCHAR(30) NOT NULL DEFAULT 'user',
        active BOOLEAN NOT NULL DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

      // =========================
      // SESSIONS
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS sessions (
        id VARCHAR(128) PRIMARY KEY,
        user_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        expires_at TIMESTAMP NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

      // =========================
      // SECTORS
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS sectors (
        id INT NOT NULL,
        sector VARCHAR(50) NOT NULL,
        user_id INT NOT NULL,
        PRIMARY KEY (user_id, id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

      // =========================
      // FACTORIES
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS factories (
        id INT NOT NULL,
        name VARCHAR(255) NOT NULL,
        highDate VARCHAR(12) NOT NULL,
        sector INT NOT NULL,
        telephone1 VARCHAR(9) NOT NULL,
        telephone2 VARCHAR(9),
        mail VARCHAR(50),
        web VARCHAR(100),
        address VARCHAR(255),
        number VARCHAR(4),
        apartment VARCHAR(10),
        city VARCHAR(10),
        province VARCHAR(10),
        postcode VARCHAR(5),
        user_id INT NOT NULL,
        PRIMARY KEY (user_id, id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id, sector)
          REFERENCES sectors(user_id, id)
      )
    ''');

      // =========================
      // EMPLOYEES
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS employees (
        id INT NOT NULL,
        name VARCHAR(50) NOT NULL,
        idFactory INT NOT NULL,
        user_id INT NOT NULL,
        PRIMARY KEY (user_id, id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (user_id, idFactory)
          REFERENCES factories(user_id, id)
          ON DELETE CASCADE
      )
    ''');

      // =========================
      // LINESENDS
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS lineSends (
        id INT NOT NULL,
        date VARCHAR(12) NOT NULL,
        factory VARCHAR(255) NOT NULL,
        observations VARCHAR(100),
        state VARCHAR(20),
        user_id INT NOT NULL,
        PRIMARY KEY (user_id, id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

      // =========================
      // MAILS
      // =========================
      await conn.query('''
      CREATE TABLE IF NOT EXISTS mails (
        id INT NOT NULL,
        mail VARCHAR(100) NOT NULL,
        host VARCHAR(100) NOT NULL,
        port INT NOT NULL,
        secure BOOLEAN NOT NULL,
        password VARCHAR(255) NOT NULL,
        user_id INT NOT NULL,
        PRIMARY KEY (user_id, id),
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    ''');

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> deleteDB(String nameBD, MySqlConnection conn) async {

    try {

      await conn.query('DROP DATABASE $nameBD');
      return true;
    }catch(_){
      return false;
    }


  }

  static Future<bool> editDB(String nameBD, String nameBDnew, MySqlConnection conn) async {


    try {

      await conn.query(
        'USE `$nameBD`',
      );

      var results =
      await conn.query(
          'SHOW TABLES'
      );

      await conn.query(
          'CREATE DATABASE $nameBDnew'
      );

            
      for (final row in results) {

            final nameTable = row[0].toString();

            await conn.query(
                'RENAME TABLE '
                    '$nameBD.$nameTable '
                    'TO '
                    '$nameBDnew.$nameTable');
      }

      await conn.query('DROP DATABASE $nameBD');
      return true;
    }catch(e){
      print(e);
      return true;
    } finally {
      await conn.close();
    }
  }
}

