import 'package:test_flutter_python/data/api/network/remote_constants.dart';
import 'package:test_flutter_python/data/dao/local_constant.dart';

class NoUserException implements Exception {
  @override
  String toString() {
    return "No existe usuario autenticado";
  }
}

class LocalException implements Exception {
  String message;
  int code;
  LocalException.fromString(this.code, String exceptionString) {
    this.code = code;
    _parseMessage();
  }
  @override
  String toString() => message ?? 'Error $code';

  _parseMessage() {
    if (code == LocalConstant.badRequest)
      message = 'Petición Incorrecta';
    else if (code == LocalConstant.notFound)
      message = 'Recurso no Encontrado';
    else if (code == LocalConstant.notUpdate)
      message = 'Accion no realizada';
    else if (code == LocalConstant.notAuthorization)
      message = 'No Autorizado (No tiene permisos)';
    else {
      message =
          "Ha ocurrido un error, vuelva a intentar o comuniquese con soporte técnico";
    }
  }
}

class ServerException implements Exception {
  String message;
  int code;

  ServerException.fromJson(this.code, Map<String, dynamic> json) {
    this.code = code;
    _parseMessage();
  }

  ServerException.fromString(this.code, String exceptionString) {
    this.code = code;
    _parseMessage();
  }

  @override
  String toString() => message ?? 'Error $code';

  _parseMessage() {
    if (code == RemoteConstants.badRequest)
      message = 'Wrong Request';
    else if (code == RemoteConstants.notFound)
      message = 'Resource not Found';
    else if (code == RemoteConstants.forbidden)
      message = 'No Access';
    else if (code == RemoteConstants.notAuthorization)
      message = 'Unauthorized';
    else if (code >= RemoteConstants.internalServerError) {
      message =
          "An has ocurred. Try again";
    } else {
      message =
          "An has ocurred. Try again";
    }
  }
}
