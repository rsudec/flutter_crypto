import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';
import 'files.dart';

class AES {
  static String aesSecretFileName = 'AES/tajni_kljuc.txt';

  static Future<bool> isGenerated() async {
    try {
      String content = await readAesSecret();
      if (content.isEmpty) {
        return false;
      }
    } catch (err) {
      return false;
    }
    return true;
  }

  static Future<void> generateSecret() async {
    String secretKey = await FlutterAesEcbPkcs5.generateDesKey(128);
    File file = File('${Files.documentsPath}/$aesSecretFileName');
    await file.writeAsString("$secretKey");
  }

  static Future<String> readAesSecret() async {
    File file = File('${Files.documentsPath}/$aesSecretFileName');
    return await file.readAsString();
  }

  static Future<File> encryptFile(String plainTextFilePath) async {
    String fileName;
    try {
      fileName = path.basename(plainTextFilePath);

      String secretKey = await readAesSecret();

      File file = File('$plainTextFilePath');

      String content = await file.readAsString();

      String encrypted =
          await FlutterAesEcbPkcs5.encryptString(content, secretKey);

      File encryptedFile =
          File('${Files.documentsPath}/AES/AESCrypt_$fileName');

      return await encryptedFile.writeAsString(encrypted);
    } catch (err) {
      return null;
    }
  }

  static Future<String> decryptFile(String encryptedFilePath) async {
    try{
      String encryptedFileName = path.basename(encryptedFilePath);
    String secretKey = await readAesSecret();

    File encryptedFile = File(encryptedFilePath);
    String encryptedContent = await encryptedFile.readAsString();

    String decryptedContent =
        await FlutterAesEcbPkcs5.decryptString(encryptedContent, secretKey);

    File decryptedFile =
        File('${Files.documentsPath}/AES/AESDecrypt_$encryptedFileName');
    await decryptedFile.writeAsString(decryptedContent);

    return decryptedContent;
    } catch(err){
      return null;
    }
    
  }
}
