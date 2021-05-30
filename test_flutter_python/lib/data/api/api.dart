import 'package:test_flutter_python/domain/model.dart';


abstract class Api {
  ///Return Auth Token.
  Future<bool> updateTask(Model model,String serverDeveloperHost);

  ///If return value is not null token is valid.
  Future<bool> eliminar(int id,String serverDeveloperHost);

  ///Return model with validation errors.
  Future<bool> insert(Model model,String serverDeveloperHost);

  /// Get user auth vaccine data.
  Future<List<Model>> listtasks(String serverDeveloperHost);

  ///Get Health Area Categories.
  Future<Model> getTask(int id,String serverDeveloperHost);

  Future<bool> validserver(String serverDeveloperHost);

}
