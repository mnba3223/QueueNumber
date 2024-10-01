import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qswait/services/environment.dart';

final ApiService apiService = ApiService(LunchEnvironment.baseUrl);

class ApiService {
  final Dio _dio;

  ApiService(String baseUrl)
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 20),
          receiveTimeout: Duration(seconds: 20),
          // validateStatus: (_) => true,
        )) {
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
    _addAuthInterceptor();
  }

  Future<void> _addAuthInterceptor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      _dio.interceptors.add(AuthInterceptor(token));
    }
  }

  Future<void> updateAuthInterceptor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
      _dio.interceptors.add(AuthInterceptor(token));
    }
  }

  Future<void> clearAuthInterceptor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.setString('token', "");
    _dio.interceptors.clear();
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    await clearAuthInterceptor(); // 确保清除现有的拦截器
    try {
      final response = await _dio.post(
        '/Auth/login',
        data: {'username': username, 'password': password},
        options: Options(
          headers: {
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$username:$password'))}',
          },
        ),
      );
      return response.data;
    } catch (e) {
      log('Login error: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> verifyToken(String token) async {
    try {
      log('Verifying token: $token');
      final response = await _dio.post(
        '/Auth/loginToken',
        options: Options(
          headers: {
            'Authorization': '$token',
          },
        ),
      );
      log('Token verification response: ${response.statusCode}');
      if (response.statusCode == 200) {
        return {'success': true, 'store': response.data['data']};
      } else {
        return {'success': false};
      }
    } catch (e) {
      log('Token verification error: $e');
      return {'success': false};
    }
  }

  Future<Response> _handleResponse(Future<Response> Function() requestFunc,
      {CancelToken? cancelToken}) async {
    try {
      final response = await requestFunc();
      // log('Response received: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DioException(
            error: "Unexpected status code: ${response.statusCode}",
            response: response,
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions);
      }
    } on DioException catch (e) {
      print('Dio error: ${e.toString()}');
      rethrow; // 再次抛出错误
    }
  }

  Future<T?> request<T>(Future<Response> Function() requestFunc,
      T Function(Map<String, dynamic>) parse) async {
    try {
      final response = await requestFunc();
      if (response.statusCode == 200 && response.data != null) {
        return parse(response.data);
      } else {
        throw DioException(
            error: "Unexpected status code: ${response.statusCode}",
            response: response,
            type: DioExceptionType.unknown,
            requestOptions: response.requestOptions);
      }
    } on DioException catch (e) {
      print('Dio error: ${e.toString()}');
      rethrow;
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    return _handleResponse(() => _dio.get(path, queryParameters: params));
  }

  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? params,
      CancelToken? cancelToken}) async {
    return _handleResponse(() => _dio.post(path,
        data: data, queryParameters: params, cancelToken: cancelToken));
  }

  Future<dynamic> put(String path,
      {dynamic data, Map<String, dynamic>? params}) async {
    return _handleResponse(
        () => _dio.put(path, data: data, queryParameters: params));
  }

  Future<dynamic> delete(String path,
      {dynamic data, Map<String, dynamic>? params}) async {
    return _handleResponse(
        () => _dio.delete(path, data: data, queryParameters: params));
  }

  Future<dynamic> uploadFile(String path, FormData formData) async {
    return _handleResponse(() => _dio.post(path, data: formData));
  }

  Future<void> downloadFile(String urlPath, String savePath) async {
    await _dio.download(urlPath, savePath,
        onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
      }
    });
  }
}

class AuthInterceptor extends Interceptor {
  String token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = '$token';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // 处理 token 失效错误，比如重新登录或刷新 token
    }
    if (err.response?.statusCode == 400) {
      // 目前拿來處理後端回傳資料有問題
    }

    super.onError(err, handler);
  }

  void updateToken(String newToken) {
    token = newToken;
  }
}
