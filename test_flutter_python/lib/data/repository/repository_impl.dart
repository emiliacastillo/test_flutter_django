import 'package:test_flutter_python/data/api/api.dart';
import 'package:test_flutter_python/data/dao/dao.dart';
import 'package:test_flutter_python/data/repository/base_repository.dart';
import 'package:test_flutter_python/data/repository/repository.dart';

import 'package:test_flutter_python/domain/model.dart';

import 'package:test_flutter_python/domain/result.dart';


class RepositoryImpl extends BaseRepository implements Repository {
  final Dao _dao;
  final Api _api;

  RepositoryImpl(this._dao, this._api);


///////////////////////////////////////
  

  @override
  Future<Result<Model>> getTicketSelect(int id,String serverDeveloperHost) async {
    try {
      final result = await _api.getTask(id, serverDeveloperHost);
      return ResultSuccess(value: result);
    } catch (ex) {
      return Result.error(
          error:
              'An has ocurred. Try again');
    }
  }

  
  @override
  Future<Result<List<Model>>> getListTickets(String serverDeveloperHost) async {
    try {
      final result = await _api.listtasks(serverDeveloperHost);
      return ResultSuccess(value: result);
    } catch (ex) {
      return ResultError(error: ex);
    }
  }

  @override
  Future<Result<bool>> setTicketSelect(Model model,String serverDeveloperHost) async {
    try {
      final result = await _api.insert(model, serverDeveloperHost);      
      return ResultSuccess(value: result);
    } catch (ex) {
      print(ex);
      return ResultError(error: 'Error creating register');
    }
  }

  @override
  Future<Result<bool>> updateTicketSelect(Model model,String serverDeveloperHost) async {
    try {
      await _api.updateTask(model, serverDeveloperHost);
      return ResultSuccess(value: true);
    } catch (ex) {
      print(ex);
      return ResultError(error: 'Error  updating register');
    }
  }

  @override
  Future<Result<bool>> deleteTicketSelect(int id,String serverDeveloperHost) async {
    try {
      await _api.eliminar(id, serverDeveloperHost);
      return ResultSuccess(value: true);
    } catch (ex) {
      print(ex);
      return ResultError(error: 'Error  deleting register');
    }
  }
   @override
  Future<Result<bool>> validserver(String serverDeveloperHost) async {
    try {
      final result = await _api.validserver(serverDeveloperHost);
      return ResultSuccess(value: result);
    } catch (ex) {
      return Result.error(
          error:
              'An has ocurred. Try again');
    }
  }
}
