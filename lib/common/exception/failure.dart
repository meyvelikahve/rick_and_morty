// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Failure with EquatableMixin implements Exception {
  final String message;
  final int? statusCode;
  final Exception? exception;
  final StackTrace stackTrace;

  Failure(
      {required this.message,
      this.statusCode,
      this.exception,
      this.stackTrace = StackTrace.empty});

  @override
  List<dynamic> get props => [message, statusCode, exception, stackTrace];

  @override
  String toString() {
    return "Failure(message $message), status_code: $statusCode, exception : $exception";
  }
}
