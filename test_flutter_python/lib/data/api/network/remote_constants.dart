class EndPoints {
  static const insert = "/inserttask";
  static const update = "/updatetask";
  static const delete = "/deletetask";
  static const list = "/tasks";
  static const gettask = "/gettask";
  static const validserver = "/validserver";
}

class RemoteConstants {
  static int success = 200;
  static int successNoBody = 204;
  static int badRequest = 400;
  static int notAuthorization = 401;
  static int forbidden = 403;
  static int notFound = 404;
  static int internalServerError = 500;
  static const unable_host_massage = 'Servidor no encontrado';
}
