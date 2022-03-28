import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'dart:io';

class FilePickerImp {
  const FilePickerImp();

  Future<File?> get file async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        var file = File(result.files.single.path ?? '');
        return file;
      } catch (e) {
        Uint8List? fileBytes = result.files.first.bytes;

        if (fileBytes == null) {
          return File('');
        } else {
          var file = File('');
          file.writeAsBytesSync(fileBytes);
          return file;
        }
      }
    } else {
// User canceled the picker
      return null;
    }
  }
}
