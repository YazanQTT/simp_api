class HttpException implements Exception {
  final _message;
  final _prefix;

  HttpException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException(String message)
      : super(message, "EasyApi Error During Communication: ");
}

class BadRequestException extends HttpException {
  BadRequestException(String message)
      : super(message, "EasyApi Invalid Request: ");
}

class UnauthorisedException extends HttpException {
  UnauthorisedException(String message)
      : super(message, "EasyApi Unauthorised: ");
}

class InvalidInputException extends HttpException {
  InvalidInputException(String message)
      : super(message, "EasyApi Invalid Input: ");
}
