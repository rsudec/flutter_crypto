import 'dart:io';
import 'dart:convert';
import 'files.dart';
import 'package:path/path.dart' as path;
import 'package:crypto/crypto.dart';

class SHA {
  static Future<String> generateHash(String chosenFilePath) async {
    try {
      String fileName = path.basename(chosenFilePath);
      File file = File(chosenFilePath);
      String content = await file.readAsString();
      var bytes = utf8.encode(content);
      var digest = sha256.convert(bytes);
      File hashedFile = File('${Files.documentsPath}/SHA/DIGEST_$fileName');
      await hashedFile.writeAsString(digest.toString());
      return digest.toString();
    } catch (err) {
      return null;
    }
  }
}
