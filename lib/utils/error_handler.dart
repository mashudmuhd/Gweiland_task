class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class ServerException extends AppException {
  ServerException(String message) : super(message);
}

class InvalidResponseException extends AppException {
  InvalidResponseException(String message) : super(message);
}

class UnknownException extends AppException {
  UnknownException(String message) : super(message);
}

class ErrorHandler {
  static void handleError(dynamic error) {
    if (error is NetworkException) {
      print('Network error: ${error.message}');
      // Handle network error UI feedback if needed
    } else if (error is ServerException) {
      print('Server error: ${error.message}');
      // Handle server error UI feedback if needed
    } else if (error is InvalidResponseException) {
      print('Invalid response error: ${error.message}');
      // Handle invalid response UI feedback if needed
    } else if (error is AppException) {
      print('App exception: ${error.message}');
      // Handle other app-related exceptions
    } else {
      print('Unexpected error: $error');
      // Handle unexpected errors UI feedback if needed
    }
  }
}
