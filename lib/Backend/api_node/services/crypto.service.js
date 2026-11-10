import crypto from "crypto";

const KEY = Buffer.from(
  "12345678901234567890123456789012",
  "utf8"
);

const IV = Buffer.from(
  "1234567890123456",
  "utf8"
);

export const decrypt = (encryptedText) => {
  const decipher = crypto.createDecipheriv(
    "aes-256-ctr",
    KEY,
    IV
  );

  let decrypted = decipher.update(
    encryptedText,
    "base64",
    "utf8"
  );

  decrypted += decipher.final("utf8");

  return decrypted;
};