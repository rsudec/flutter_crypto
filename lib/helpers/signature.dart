import 'dart:io';
import 'rsa.dart';
import 'sha.dart';
import 'files.dart';
import 'package:path/path.dart' as path;

class SIGNATURE {
  static Future<String> signFile(String chosenFilePath) async {
    try {
      String fileName = path.basename(chosenFilePath);
      String fileDigest = await SHA.generateHash(chosenFilePath);
      String fileDigestEncrypted = await RSA.encryptString(fileDigest,
          false); //encrypt with publicKey by default, false to encrypt with privateKey
      File signatureFile =
          File('${Files.documentsPath}/SIGNATURE/SIGNATURE_$fileName');
      await signatureFile.writeAsString(fileDigestEncrypted);
      return fileDigestEncrypted;
    } catch (err) {
      return null;
    }
  }

  static Future<int> verifySignature(
      String chosenFilePath, signatureFilePath) async {
    try {
      File signatureFile = File(signatureFilePath);
      String existingSignature = await signatureFile.readAsString();

      String chosenFileSignature = await signFile(chosenFilePath);

      if (existingSignature == chosenFileSignature) {
        return 1;
      }
      return 0;
    } catch (err) {
      return -1;
    }
  }
}
