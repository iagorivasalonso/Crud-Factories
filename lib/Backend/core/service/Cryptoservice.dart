import 'package:encrypt/encrypt.dart';

class CryptoService {

  static final Key _key= Key.fromUtf8('12345678901234567890123456789012'); // 32 bytes
  static final IV _iv = IV.fromUtf8('1234567890123456'); // 16 bytes

  static final  Encrypter _encrypter = Encrypter(AES(_key));

  static String encrypt(String text) {

    final encripted = _encrypter.encrypt(
        text,
        iv: _iv,
    );

    return encripted.base64;

  }

  static String decrypt(String encryptedText) {

    return _encrypter.decrypt64(
        encryptedText,
        iv: _iv
    );

  }
}
