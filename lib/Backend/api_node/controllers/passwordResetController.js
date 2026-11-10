console.log('[RESET] 1. Inicio');

connection = await getConnection(req.body);
console.log('[RESET] 2. Conexión MySQL obtenida');

const [users] = await connection.query(
  `
  SELECT id, username, mail
  FROM users
  WHERE username = ? AND mail = ? AND active = 1
  LIMIT 1
  `,
  [username, mail]
);

console.log('[RESET] 3. Consulta usuario terminada');

if (users.length === 0) {
  // Tu código actual...
}

const user = users[0];

const [adminMails] = await connection.query(
  `
  SELECT m.mail, m.host, m.port, m.secure, m.password
  FROM mails m
  INNER JOIN users u ON u.id = m.user_id
  WHERE u.role = 'admin'
    AND u.active = 1
  ORDER BY m.id
  `
);

console.log('[RESET] 4. Cuentas SMTP obtenidas:', adminMails.length);

// Antes del bucle:
console.log('[RESET] 5. Preparando token y correo');

// Justo antes de sendMailUser:
console.log('[RESET] 6. Intentando enviar correo');

const results = await sendMailUser({
  // Mantén aquí tus parámetros actuales
});

console.log('[RESET] 7. Resultado del envío:', results);