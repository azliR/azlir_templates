import 'dart:developer';

abstract class Failure {
  Failure(this.message, {this.error, this.stackTrace}) {
    log(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  final String message;
  final Object? error;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Failure(message: $message, error: $error, stackTrace: $stackTrace)';
  }
}

final class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.message, {super.error, super.stackTrace});
}

final class HttpFailure extends Failure {
  HttpFailure(super.message, {super.error, super.stackTrace});
}
