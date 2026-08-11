import mysql from 'mysql2/promise';

class DatabaseRepository {

  async createDatabase({ host, port = 3306, user, password, database }) {

    let executeQuery;

    try {

      executeQuery = await mysql.createConnection({
        host,
        port,
        user,
        password
      });

      await executeQuery.query(
        `CREATE DATABASE IF NOT EXISTS \`${database}\``
      );

          console.log(`BD creada: ${database}`);

          // Cerramos esta conexión
          await executeQuery.end();
          executeQuery = null;

          const tablesResult = await this.createTables({
                host,
                port,
                user,
                password,
                database
              });

              if (!tablesResult.ok) {
                return tablesResult;
              }

              return {
                ok: true,
                message: `Base de datos ${database} y tablas creadas correctamente`
              };

            } catch (error) {

              console.error('Error creando base de datos:', error);

              return {
                ok: false,
                error: {
                  message: error.message,
                  code: error.code
                }
              };

            } finally {

              if (executeQuery) {
                await executeQuery.end();
              }
            }


  }


     async createTables({ host, port = 3306, user, password, database }) {
      // Crear tablas
       let executeQuery;

      try {
      executeQuery = await mysql.createConnection({ host, port, user, password,database });

                  await executeQuery.query(`
                      CREATE TABLE IF NOT EXISTS sectors (
                      id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      sector VARCHAR(50) NOT NULL
                    )
                 `);

                  await executeQuery.query(`
                    CREATE TABLE IF NOT EXISTS factories (
                      id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(255) NOT NULL,
                      highDate VARCHAR(12) NOT NULL,
                      sector INT(11) NOT NULL,
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
                      FOREIGN KEY (sector) REFERENCES sectors(id)
                    )
                  `);

                  await executeQuery.query(`
                    CREATE TABLE IF NOT EXISTS employees (
                      id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(50) NOT NULL,
                      idFactory INT(11) NOT NULL,
                      FOREIGN KEY (idFactory) REFERENCES factories(id) ON DELETE CASCADE
                    )
                  `);

                  await executeQuery.query(`
                    CREATE TABLE IF NOT EXISTS lineSends (
                      id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      date VARCHAR(12) NOT NULL,
                      factory VARCHAR(255) NOT NULL,
                      observations VARCHAR(100),
                      state VARCHAR(20)
                    )
                  `);

                  await executeQuery.query(`
                    CREATE TABLE IF NOT EXISTS mails (
                       id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       mail VARCHAR(100) NOT NULL,
                       host VARCHAR(100) NOT NULL,
                       port INT NOT NULL,
                       secure BOOLEAN NOT NULL,
                       password VARCHAR(255) NOT NULL
                     );
                  `);
          return {
            ok: true,
            message: `Tablas creadas correctamente en ${database}`
          };

     } catch (error) {
          console.error('Error creando tablas:', error);

          return {
            ok: false,
            error: {
              message: error.message,
              code: error.code
            }
          };

    } finally {
        if (executeQuery) await executeQuery.end(); // cerrar conexión correctamente
    }
  }

async renameDatabase({ host, port = 3306, user, password, database, newDatabase}) {

  let connection;

  try {


    // Validar parámetros
    if (!database || !newDatabase) {
      return {
        ok: false,
        error: {
          message: 'El nombre de la base de datos no puede estar vacío.',
          code: 'INVALID_DATABASE_NAME'
        }
      };
    }

    if (database === newDatabase) {
      return {
        ok: false,
        error: {
          message: 'El nuevo nombre de la base de datos debe ser diferente.',
          code: 'SAME_DATABASE_NAME'
        }
      };
    }

    connection = await mysql.createConnection({
      host,
      port,
      user,
      password
    });



  
    await connection.query(`CREATE DATABASE \`${newDatabase}\``);


    const [tables] = await connection.query(
      `SHOW TABLES FROM \`${database}\``
    );

    for (const row of tables) {
      const tableName = Object.values(row)[0];

      await connection.query(`
        CREATE TABLE \`${newDatabase}\`.\`${tableName}\`
        LIKE \`${database}\`.\`${tableName}\`
      `);

      await connection.query(`
        INSERT INTO \`${newDatabase}\`.\`${tableName}\`
        SELECT * FROM \`${database}\`.\`${tableName}\`
      `);
    }


    await connection.query(`DROP DATABASE \`${database}\``);

           return {
             ok: true,
             message: `Base de datos renombrada de ${database} a ${newDatabase}`
           };

         } catch (error) {

           console.error('Error renombrando la base de datos:', {
             message: error.message,
             code: error.code
           });

           return {
             ok: false,
             error: {
               message: error.message,
               code: error.code
             }
           };

         } finally {
           if (connection) await connection.end();
         }

    }

  async deleteDatabase({ host, port = 3306, user, password, database}) {

  console.log('🚨 DELETE DATABASE EJECUTADO:', database);
 let executeQuery;

         try{
          executeQuery = await mysql.createConnection({ host, port, user, password });
              const [dbExists] = await executeQuery.query(
                        `SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ?`,
                        [database]);

              if (dbExists.length === 0) {
                throw new Error(`La base de datos "${database}" no existe.`);
              }

                await executeQuery.query(`DROP DATABASE \`${database}\``);
                return {
                         ok: true,
                         message: `Base de datos ${database} eliminada correctamente`
                       };;
          } catch (error) {

                  console.error('Error eliminando la base de datos:', {
                    message: error.message,
                    code: error.code
                  });

                  return {
                    ok: false,
                    error: {
                      message: error.message,
                      code: error.code
                    }
                  };
           }  finally{
              if (executeQuery) await executeQuery.end();
         }
      }
}

const dbRepo = new DatabaseRepository();
export default dbRepo;