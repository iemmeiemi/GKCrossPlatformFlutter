import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {

  Future<String> imagePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

      if(result != null) {
        return result.files.single.path!;
      }
      return "";
    } on Exception catch (e) {
      throw("ImagePicker error: $e");
    }
  }
}