import 'package:encrypt/encrypt.dart';

class Encrypted {
  static String from(String hash) {
    final key = Key.fromUtf8('uwEGgr4jv6ez0nic6dc2l9Ot4gFRVgpz');
    final encrypter = Encrypter(AES(key));
    final iv = IV.fromLength(16);

    return encrypter.decrypt64(hash, iv: iv);
  }

  static String to(String password) {
    final key = Key.fromUtf8('uwEGgr4jv6ez0nic6dc2l9Ot4gFRVgpz');
    final encrypter = Encrypter(AES(key));
    final iv = IV.fromLength(16);

    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }
}