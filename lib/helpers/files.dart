import 'package:file_picker/file_picker.dart';

class Files {
  static String documentsPath = '/storage/emulated/0/Android/data/com.example.robert_sudec_projekt_flutter/files/Documents';

  static Future<String> getPickedFilePath() async {
    return await FilePicker.getFilePath(type: FileType.CUSTOM, fileExtension: 'txt'); 
  }
  static Future<Map<String,String>> getPickedMultipleFilesPath() async {
    return await FilePicker.getMultiFilePath(type: FileType.CUSTOM, fileExtension: 'txt');
  }
}