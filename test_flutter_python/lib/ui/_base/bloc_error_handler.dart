import 'package:rxdart/rxdart.dart';

class ErrorHandlerBloC {
  BehaviorSubject<String> _errorMessageController = new BehaviorSubject();

  Stream<String> get errorMessageStream => _errorMessageController.stream;

  onError(dynamic error) {
    if (error != null)
      _errorMessageController.sink.add(getResponseError(error));
    else
      clearError();
  }

  String getResponseError(dynamic error) {
//    if (error is SocketException) {
//      return R.string.error_check_your_connection;
//    }
//    if (error is ServerException) {
//      return error.message;
//    } else {
//      return error.toString();
//    }
    return error.toString();
  }

  clearError() {
    _errorMessageController.sink.add(null);
  }

  void disposeErrorHandlerBloC() {
    _errorMessageController.close();
  }
}
