import 'dart:async';
import 'dart:io';
import 'package:test_flutter_python/data/dao/dao.dart';
import 'package:test_flutter_python/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

export 'package:http/http.dart';

typedef void OnDownloadProgressCallback(int receivedBytes, int totalBytes);

class NetworkHandler {
  final String _baseUrl;
  final Dao tokenDao;
  final Logger logger;
  final String refreshTokenURL = 'refresh';

  NetworkHandler(this._baseUrl, this.tokenDao, this.logger);

  ///Returns the common headers with authentication values
  Future<Map<String, String>> _commonHeaders({bool requireAuth = false}) async {
    if (!requireAuth) return {};

    final token = await tokenDao.getSavedToken();
    if (token == null || token.isEmpty) return {};
    return {'Authorization': 'bearer $token'};
  }

  ///Get operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> get({
    @required String path,
    String params = '',
    String baseUrl,
    Map<String, String> headers = const {},
  }) async {
    final url = (baseUrl ?? _baseUrl) + path + params;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> GET: $url");
      logger.log("-> HEADERS: $_headers");
      final res = await http.get(url, headers: _headers);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Post operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> post({
    @required String path,
    String baseUrl,
    bool requireAuth = true,
    Map<String, String> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders(requireAuth: requireAuth);
    _headers.addAll(headers);

    try {
      logger.log("-> POST: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");
      final res = await http.post(_url, headers: _headers, body: body);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Post operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> postWithEncode({
    @required String path,
    String baseUrl,
    bool requireAuth = true,
    String body = "",
    Map<String, String> headers = const {},
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders(requireAuth: requireAuth);
    _headers.addAll(headers);

    try {
      logger.log("-> POST: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");
      final res = await http.post(_url, headers: _headers, body: body);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Put operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> put({
    @required String path,
    String baseUrl,
    Map<String, String> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> PUT: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");
      final res = await http.put(_url, headers: _headers, body: body);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Put operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> putWithEncode({
    @required String path,
    String baseUrl,
    String body = "",
    Map<String, String> headers = const {},
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> PUT: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");
      final res = await http.put(_url, headers: _headers, body: body);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Patch operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request's content type is application/json
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> patch({
    @required String path,
    String baseUrl,
    Map<String, String> body = const {},
    Map<String, String> headers = const {},
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> PATCH: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");
      final res = await http.patch(_url, headers: _headers, body: body);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  ///Delete operations.
  ///-The base URL by default is the one provided by the Injector.
  ///-The [path] is mandatory
  ///-The request already handles authentication
  ///-The request already handles refresh token implementation
  Future<http.Response> delete({
    @required String path,
    String baseUrl,
    Map<String, String> headers = const {},
  }) async {
    final url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> DELETE: $url");
      logger.log("-> HEADERS: $_headers");
      final res = await http.delete(url, headers: _headers);
      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.body}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }

  Future<Response> postFile({
    @required String path,
    String baseUrl,
    Map<String, dynamic> body = const {},
    Map<String, String> headers = const {},
    @required List<File> files,
  }) async {
    final _url = (baseUrl ?? _baseUrl) + path;
    final _headers = await _commonHeaders();
    _headers.addAll(headers);

    try {
      logger.log("-> POST: $_url");
      logger.log("-> HEADERS: $_headers");
      logger.log("-> BODY: $body");

      if (files.length > 0) {
        List<MultipartFile> multipartFiles = [];
        for (var f in files) {
          multipartFiles
              .add(await MultipartFile.fromFile(f.path, filename: '${f.path}'));
        }
        var filesMap = {'files': multipartFiles};
        body.addAll(filesMap);
      }

      FormData formData = FormData.fromMap(body);

      Dio dio = new Dio();
      final res = await dio.post(_url,
          data: formData,
          options: Options(
            method: 'POST',
            responseType: ResponseType.json,
            headers: _headers,
          ));

      logger.log("<- RESPONSE CODE: ${res.statusCode}");
      logger.log("<- RESPONSE BODY: ${res.toString()}");
      return res;
    } catch (ex) {
      logger.log("<- EXEPTION: $ex");
      throw ex;
    }
  }
}
