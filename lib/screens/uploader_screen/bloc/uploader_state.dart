import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class UploaderState extends Equatable {
  const UploaderState({
    this.message = 'No file selected',
  });

  final String message;
}

class ReadyForUpload extends UploaderState {
  const ReadyForUpload({
    String message = 'Ready!',
  }) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class FileSelected extends UploaderState {
  const FileSelected({
    required this.file,
    required String message,
  }) : super(message: message);

  final File file;

  @override
  List<Object?> get props => [file, message];
}

class UploadingFile extends UploaderState {
  const UploadingFile({
    String message = 'Please wait...',
  }) : super(message: message);

  @override
  List<Object?> get props => [message];
}
