import 'dart:convert';
import 'package:test_flutter_python/data/api/api.dart';
import 'package:test_flutter_python/data/api/network/network_handler.dart';
import 'package:test_flutter_python/data/api/network/remote_constants.dart';
import 'package:test_flutter_python/data/converter/converter.dart';
import 'package:test_flutter_python/domain/exceptions/exceptions.dart';
import 'package:test_flutter_python/domain/model.dart';

class ApiImpl implements Api {
  final NetworkHandler _networkHandler;
  final ApiConverter _apiConverter;

  ApiImpl(this._networkHandler, this._apiConverter);

  @override
  Future<List<Model>> listtasks(String serverDeveloperHost) async {
    
       final res = await _networkHandler.get(baseUrl: serverDeveloperHost,
      path: '${EndPoints.list}',
      headers: {"Content-Type": "application/json"},
    );
   
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      return l.map((e) => _apiConverter.modelFromJson(e)).toList();
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
   
  }

  @override
  Future<Model> getTask(int id, String serverDeveloperHost) async {
    final res = await _networkHandler.get(baseUrl: serverDeveloperHost,
      path: '${EndPoints.gettask}/$id',
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      return json.decode(res.body);
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
  }

  @override
  Future<bool> updateTask(Model model,String serverDeveloperHost) async {
    var body = {
      'id': model.id,
      'title': model.title,
    };
    final res = await _networkHandler.postWithEncode(baseUrl: serverDeveloperHost,
        path: '${EndPoints.update}',
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    if (res.statusCode == 200) {
      return true;
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
  }

  @override
  Future<bool> insert(Model model,String serverDeveloperHost) async {
    var body = {
      'title': model.title,
    };
    final res = await _networkHandler.postWithEncode(baseUrl: serverDeveloperHost,
        path: '${EndPoints.insert}',
        headers: {"Content-Type": "application/json"},
        body: json.encode(body));

    if (res.statusCode == 200) {
      return true;
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
  }

  @override
  Future<bool> eliminar(int id,String serverDeveloperHost) async {
    final res = await _networkHandler.delete(baseUrl: serverDeveloperHost,
      path: '${EndPoints.delete}/$id',
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      return true;
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
  }

   @override
  Future<bool> validserver(String serverDeveloperHost) async {
    try {
      final res = await _networkHandler.get(baseUrl: serverDeveloperHost,
      path: '${EndPoints.validserver}',
      headers: {"Content-Type": "application/json"},
    );

    if (res.statusCode == 200) {
      return true;
    }
    throw ServerException.fromJson(res.statusCode, json.decode(res.body));
    } catch (e) {
       return false;

    }
    
  }
}
