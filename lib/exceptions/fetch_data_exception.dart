class NetworkException implements Exception {
  final dynamic message;
  final dynamic prefix;

  NetworkException([this.message, this.prefix]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}

class FetchDataException extends NetworkException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends NetworkException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

class InvalidInputException extends NetworkException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
