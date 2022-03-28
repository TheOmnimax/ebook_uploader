import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'package:ebook_uploader/utils/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class UploaderBloc extends Bloc<UploaderEvent, UploaderState> {
  UploaderBloc() : super(const ReadyForUpload()) {
    on<SelectorButton>(_selectFile);
    on<UploadFile>(_uploadFile);
  }

  Future _selectFile(SelectorButton event, Emitter<UploaderState> emit) async {
    const filePicker = FilePickerImp();
    final file = await filePicker.file;

    if (file != null) {
      final filename = basename(file.path);
      emit(FileSelected(
        file: file,
        message: filename,
      ));
    }
  }

  Future _uploadFile(UploadFile event, Emitter<UploaderState> emit) async {
    final uri = Uri.parse('https://ereader-341202.uc.r.appspot.com/upload');

    final headers = {
      HttpHeaders.authorizationHeader: event.token,
    };

    emit(
      const UploadingFile(
        message: 'Reading file...',
      ),
    );

    final fileData = event.file.readAsBytesSync();

    emit(
      const UploadingFile(
        message: 'Uploading file...',
      ),
    );
    final response = await http.post(
      uri,
      headers: headers,
      body: fileData,
    );

    final statusCode = response.statusCode;

    final responseBodyRaw = response.body as String;
    final responseBody = json.decode(responseBodyRaw) as Map<String, dynamic>;

    final String message;

    if (responseBody.containsKey('info')) {
      final info = responseBody['info'];
      message = '$statusCode: $info\n\nYou can now upload another file.';
    } else {
      message = '$statusCode\n\nYou can now upload another file.';
    }

    emit(ReadyForUpload(message: message));
  }
}
