import 'dart:io';
import 'files.dart';
import 'package:path/path.dart' as path;
import 'package:rsa_util/rsa_util.dart';

class RSA {
  static String rsaPrivateKeyFileName = 'RSA/privatni_kljuc.txt';
  static String rsaPublicKeyFileName = 'RSA/javni_kljuc.txt';

  static Future<void> generateKeys() async {
    final List<String> keys = RSAUtil.generateKeys(1024);
    String publicKey = keys[0];
    String privateKey = keys[1];
    File filePublic = File('${Files.documentsPath}/$rsaPublicKeyFileName');
    await filePublic.writeAsString(publicKey);
    File filePrivate = File('${Files.documentsPath}/$rsaPrivateKeyFileName');
    await filePrivate.writeAsString(privateKey);
  }

  static Future<String> readPrivateRSAKey() async {
    File file = File('${Files.documentsPath}/$rsaPrivateKeyFileName');
    return await file.readAsString();
  }

  static Future<String> readPublicRSAKey() async {
    File file = File('${Files.documentsPath}/$rsaPublicKeyFileName');
    return await file.readAsString();
  }

  static Future<bool> encryptFile(String plainTextFilePath) async {
    try {
      String fileName = path.basename(plainTextFilePath);
      String privateKey = await readPrivateRSAKey();
      String publicKey = await readPublicRSAKey();
      RSAUtil rsa = RSAUtil.getInstance(publicKey, privateKey);
      File plainTextFile = File(plainTextFilePath);
      String plainTextContent = await plainTextFile.readAsString();
      String encryptedContent = rsa.encryptByPublicKey(plainTextContent);
      File encryptedFile =
          File('${Files.documentsPath}/RSA/RSACrypt_$fileName');
      await encryptedFile.writeAsString(encryptedContent);
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<bool> decryptFile(String encryptedFilePath) async {
    try {
      String fileName = path.basename(encryptedFilePath);
      String privateKey = await readPrivateRSAKey();
      String publicKey = await readPublicRSAKey();
      RSAUtil rsa = RSAUtil.getInstance(publicKey, privateKey);
      File encryptedFile = File(encryptedFilePath);
      String encryptedContent = await encryptedFile.readAsString();
      String decryptedContent = rsa.decryptByPrivateKey(encryptedContent);
      File decryptedFile =
          File('${Files.documentsPath}/RSA/RSA_Decrypt$fileName');
      await decryptedFile.writeAsString(decryptedContent);
      return true;
    } catch (err) {
      return false;
    }
  }

  static Future<String> encryptString(String data,
      [bool byPublic = true]) async {
    try {
      String privateKey = await readPrivateRSAKey();
      String publicKey = await readPublicRSAKey();
      RSAUtil rsa = RSAUtil.getInstance(publicKey, privateKey);
      String encryptedData = byPublic
          ? rsa.encryptByPublicKey(data)
          : rsa.encryptByPrivateKey(data);
      return encryptedData;
    } catch (err) {
      return null;
    }
  }
}
