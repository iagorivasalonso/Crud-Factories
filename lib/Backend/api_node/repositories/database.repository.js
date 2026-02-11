import mysql from 'mysql2/promise';

class DatabaseRepository {

  async createDatabase({ host, port = 3306, user, password,database}) {

    let executeQuery;

       try {

           executeQuery = await mysql.createConnection({ host, port, user, password, })

            await executeQuery.query(`CREATE DATABASE IF NOT EXISTS \`${database}\``);
           await executeQuery.query(`USE \`${database}\``);

           return true;

      }catch(error){
        console.log(error)
            return error;

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
                      apartament VARCHAR(10),
                      city VARCHAR(10),
                      province VARCHAR(10),
                      postalcode VARCHAR(5),
                      FOREIGN KEY (sector) REFERENCES sectors(id)
                    )
                  `);

                  await executeQuery.query(`
                    CREATE TABLE IF NOT EXISTS empleoyes (
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
                      company VARCHAR(20),
                      email VARCHAR(50),
                      password VARCHAR(100)
                    )
                  `);
             return true;

     } catch (error) {
        console.error('Error creando tablas:', error.message);
        throw error

    } finally {
        if (executeQuery) await executeQuery.end(); // cerrar conexión correctamente
    }
  }

  async renameDatabase({ host, port = 3306, user, password, database,databaseNew }) {

       let executeQuery;

       try{
           executeQuery = await mysql.createConnection({ host, port, user, password });

            await executeQuery.query(`CREATE DATABASE IF NOT EXISTS \`${databaseNew}\``);

            const [dbExists] = await executeQuery.query(
                     `SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ?`,
                      [database]
                    );

            if (dbExists.length === 0) {
              throw new Error(`La base de datos "${database}" no existe.`);
            }

             // Copiar tablas del viejo nombre al nuevo
             const [tables] = await executeQuery.query(`SHOW TABLES FROM \`${database}\``);

             for (let row of tables) {
               const tableName = Object.values(row)[0];
               await executeQuery.query(`RENAME TABLE \`${database}\`.\`${tableName}\` TO \`${databaseNew}\`.\`${tableName}\``);
             }

             // borrar base vieja
              await executeQuery.query(`DROP DATABASE \`${database}\``);
               return true;
       } catch (error) {
           console.error('Error renombrando la base de datos:', {
             message: error.message,
             code: error.code
           });
           throw error;

         }   finally{
            if (executeQuery) await executeQuery.end();
       }
    }

  async deleteDatabase({ host, port = 3306, user, password, database}) {

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
                return true;
          } catch (error) {
             console.error('Error eliminando la base de datos:', {
               message: error.message,
               code: error.code
             });
             throw error;

           }  finally{
              if (executeQuery) await executeQuery.end();
         }
      }
}

const dbRepo = new DatabaseRepository();
export default dbRepo;