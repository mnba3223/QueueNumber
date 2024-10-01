
// import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:qswait/services/user_service.dart';
// import 'package:qswait/utils/string_util.dart';

// typedef ParseResponseFunc<T> = T Function(Map<String, dynamic> input);

// class HttpService {
//   static const String brand = 'dolce';
//   // fstatic final String baseUrl = 'http://ap.boaz-smart.com';
//   //測試區
//   static const String baseUrl = 'http://192.168.0.125';
//   // 正式區
//   // static const String baseUrl = 'http://35.221.198.223';

//   static Dio client = Dio(BaseOptions(
//     connectTimeout: Duration(seconds: 1),
//     receiveTimeout:  Duration(seconds: 4),
//     responseType: ResponseType.plain,
//   ));

//   static apiUrl(String path) {
//     return '$baseUrl/api${path.startsWith('/') ? '' : '/'}$path';
//   }

//   static imageUrl(String path) {
//     if (StringUtil.isEmpty(path)) return '';

//     return '$baseUrl${path.startsWith('/') ? '' : '/'}$path';
//   }

//   static Map<String, dynamic> createQueryParams(
//       {Map<String, dynamic>? params}) {
//     params = params ?? {};
//     // params['locale'] = LocaleService.code;

//     debugPrint('params: $params');
//     return params;
//   }

//   static Map<String, dynamic> createHeaders(
//       {Map<String, String>? headers, bool withToken = false}) {
//     headers = headers ?? {};

//     if (withToken) {
//       headers['Authorization'] = 'Bearer ${UserService.accessToken}';
//     }

//     debugPrint('header: ${headers.toString()}');

//     return headers;
//   }

//   static Future<Map<String, dynamic>?> doRequest<B>(Function action) async {
//     Response? response;

//     try {
//       response = await action();
//     } on DioError catch (e) {
//       response = e.response;
//       debugPrint('response error:${e.toString()}');
//     } catch (e) {
//       debugPrint('response error:${e.toString()}');
//       return null;
//     }

//     if (response == null || response.data == null) return null;

//     debugPrint('response: ${response.data}');

//     try {
//       return jsonDecode(response.data);
//     } catch (e) {
//       debugPrint('decode response error:${e.toString()}');
//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> get(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = false,
//   }) async {
//     String url = apiUrl(path);
//     debugPrint('request url: $url');

//     return await doRequest(
//       () => client.get(
//         url,
//         queryParameters: createQueryParams(params: params),
//         options: Options(
//           headers: createHeaders(headers: headers, withToken: withToken),
//         ),
//       ),
//     );
//   }

//   static Future<T?> getJson<T>(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     ParseResponseFunc<T>? parseAction,
//     bool withToken = false,
//   }) async {
//     Map<String, dynamic>? map =
//         await get(path, headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return parseAction!(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> post<B>(
//     String path,
//     B body, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     String url = apiUrl(path);

//     debugPrint('request url: $url');

//     if (body is FormData) {
//       debugPrint('body: ${body.fields}');
//     } else {
//       debugPrint('body: $body');
//     }

//     return await doRequest(
//       () => client.post(
//         url,
//         data: body,
//         queryParameters: createQueryParams(params: params),
//         options: Options(
//           headers: createHeaders(headers: headers, withToken: withToken),
//         ),
//       ),
//     );
//   }

//   static Future<DynamicResponse?> postDynamic(
//     String path, {
//     Map<String, dynamic>? body,
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await post<Map<String, dynamic>>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return DynamicResponse.fromJson(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<T?> postJson<T>(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     Map<String, dynamic>? body,
//     ParseResponseFunc<T>? parseAction,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await post<Map<String, dynamic>>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return parseAction!(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<DynamicResponse?> postFormDynamic(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     FormData? body,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await post<FormData>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return DynamicResponse.fromJson(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<T?> postForm<T>(
//     String path,
//     FormData body,
//     ParseResponseFunc<T> parseAction, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await post<FormData>(path, body,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return parseAction(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> put<B>(
//     String path,
//     B body, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     String url = apiUrl(path);

//     debugPrint('request url: $url');
//     debugPrint('body: $body');

//     return await doRequest(() => client.put(url,
//         data: body,
//         queryParameters: createQueryParams(params: params),
//         options: Options(
//             headers: createHeaders(headers: headers, withToken: withToken))));
//   }

//   static Future<DynamicResponse?> putDynamic(
//     String path, {
//     Map<String, dynamic>? body,
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await put<Map<String, dynamic>>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return DynamicResponse.fromJson(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<DynamicResponse?> putFormDynamic(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     FormData? body,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await put<FormData>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return DynamicResponse.fromJson(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }

//   static Future<Map<String, dynamic>?> delete<B>(
//     String path,
//     B body, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     String url = apiUrl(path);

//     debugPrint('request url: $url');
//     debugPrint('body: $body');

//     return await doRequest(() => client.delete(url,
//         data: body,
//         queryParameters: createQueryParams(params: params),
//         options: Options(
//             headers: createHeaders(headers: headers, withToken: withToken))));
//   }

//   static Future<DynamicResponse?> deleteDynamic(
//     String path, {
//     Map<String, dynamic>? body,
//     Map<String, String>? headers,
//     Map<String, dynamic>? params,
//     bool withToken = true,
//   }) async {
//     Map<String, dynamic>? map = await delete<Map<String, dynamic>>(path, body!,
//         headers: headers, params: params, withToken: withToken);

//     if (map == null) return null;

//     try {
//       return DynamicResponse.fromJson(map);
//     } catch (e) {
//       debugPrint('parse response error:${e.toString()}');

//       return null;
//     }
//   }
// }
