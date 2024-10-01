// class ApiResponse<T> {
//   final int code;
//   final String message;
//   final T? data;

//   ApiResponse({required this.code, required this.message, this.data});
//   // 解析单个对象
//   factory ApiResponse.fromJson(
//       Map<String, dynamic> json, T Function(dynamic) fromJson) {
//     return ApiResponse<T>(
//       code: json['code'] ?? -1,
//       message: json['message'] ?? '',
//       data: json.containsKey('data') ? fromJson(json['data']) : null,
//     );
//   }

//   // 解析泛型列表
//   factory ApiResponse.fromJsonList(
//       Map<String, dynamic> json, List<T> Function(List<dynamic>) fromJsonList) {
//     return ApiResponse<T>(
//       code: json['code'] ?? -1,
//       message: json['message'] ?? '',
//       data: json.containsKey('data')
//           ? fromJsonList(json['data'] as List<dynamic>) as T
//           : null,
//     );
//   }
//   bool get isSuccess => code == 200; // 根据实际情况判断成功的 code
// }

///version 2  api response class

// class ApiResponse<T> {
//   final bool success;
//   final String message;
//   final T? data;

//   ApiResponse({required this.success, required this.message, this.data});

//   // 解析单个对象
//   factory ApiResponse.fromJson(
//       Map<String, dynamic> json, T Function(dynamic) fromJson) {
//     return ApiResponse<T>(
//       success: json['Success'] ?? false,
//       message: json['Message'] ?? '',
//       data: json.containsKey('data') ? fromJson(json['data']) : null,
//     );
//   }

//   // 解析泛型列表
//   factory ApiResponse.fromJsonList(
//       Map<String, dynamic> json, T Function(List<dynamic>) fromJsonList) {
//     return ApiResponse<T>(
//       success: json['code'] ?? false,
//       message: json['message'] ?? '',
//       data: json.containsKey('data')
//           ? fromJsonList(json['data'] as List<dynamic>)
//           : null,
//     );
//   }

//   bool get isSuccess => success; // 根据 Success 字段判断请求是否成功
// }

///version 3
///
///
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  // 解析单个对象
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJson) {
    dynamic data = json['data'];
    if (data is List && data.isNotEmpty) {
      data = data.first; // 取列表中的第一个元素
      return ApiResponse<T>(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: data != null ? fromJson(data) : null,
      );
    }
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json.containsKey('data') ? fromJson(json['data']) : null,
    );
  }

  // 解析泛型列表
  factory ApiResponse.fromJsonList(
      Map<String, dynamic> json, T Function(List<dynamic>) fromJsonList) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json.containsKey('data')
          ? fromJsonList(json['data'] as List<dynamic>)
          : null,
    );
  }

  bool get isSuccess => success; // 根据 Success 字段判断请求是否成功
}
