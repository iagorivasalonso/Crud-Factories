import mysql from "mysql2/promise";

export const executeDbAction = async ({ action, host, port, user, password, database }) => {
    // ⚡ Solo Web llamará aquí vía HTTP
    if (!action) throw new Error("No action specified");

    // Conexión dinámica
    const connection = await mysql.createConnection({ host, port, user, password, database });

    switch(action) {
        case "create":
            await connection.query(`CREATE DATABASE IF NOT EXISTS \`${database}\``);
            return `Database ${database} created`;
        case "delete":
            await connection.query(`DROP DATABASE IF EXISTS \`${database}\``);
            return `Database ${database} deleted`;
        case "connect":
            // Aquí solo testeamos conexión
            return `Connected to ${database}`;
        default:
            throw new Error(`Unknown action ${action}`);
    }
};
