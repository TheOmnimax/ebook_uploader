import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class UploaderEvent extends Equatable {
  const UploaderEvent();
}

class SelectorButton extends UploaderEvent {
  const SelectorButton();

  @override
  List<Object?> get props => [];
}

class UploadFile extends UploaderEvent {
  const UploadFile({
    required this.file,
    required this.token,
  });

  final File file; // TODO: Is this the right place to put this?
  final String token;

  @override
  List<Object?> get props => [file];
}
