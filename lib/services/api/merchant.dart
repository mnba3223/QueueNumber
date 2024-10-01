import 'package:dio/dio.dart';
import 'package:qswait/models/response/api_response.dart';
import 'package:qswait/services/api_service.dart';

import '../../models/admin/Category_Class.dart';

Future<ApiResponse<List<Category>>> fetchAllCategories(String storeId,
    {CancelToken? cancelToken}) async {
  try {
    final response = await apiService.post(
      '/Merchant/getStoreQueueInfo',
      data: {"storeId": storeId},
      cancelToken: cancelToken,
    );

    return ApiResponse.fromJsonList(response.data,
        (list) => list.map((json) => Category.fromJson(json)).toList());
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<List<Category>>(
      success: false,
      message: 'Error occurred: $e',
      data: [],
    );
  }
}

// Future<ApiResponse<void>> updateCategory(
//     ApiService apiService, Category category) async {
//   try {
//     final response = await apiService.post(
//       '/updateCategory',
//       data: category.toJson(),
//     );
//     return ApiResponse<void>(
//       success: response.data['success'],
//       message: response.data['message'] ?? 'Update successful',
//     );
//   } catch (e) {
//     print('API call error: $e');
//     return ApiResponse<void>(
//       success: false,
//       message: 'Error occurred: $e',
//     );
//   }
// }
/// 更新分類的API
/// action 帶參數為  create  update  delete 分別對應 新增 刪除 修改
Future<ApiResponse<void>> updateCategoryAPI(
    Category category, String action) async {
  try {
    final categoryData = category.toJson();
    // 修改ID如果是創建動作

    if (action == "create") {
      categoryData['id'] = 0; // 或其他後端系統接受的值
    }
    categoryData['action'] = action;
    final response = await apiService.post(
      '/Merchant/queueTypeEdit',
      data: categoryData,
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? '操作成功',
    );
  } catch (e) {
    // print('API 請求錯誤: $e');
    if (e is DioException) {
      // 如果是DioException，嘗試解析服務器返回的錯誤消息
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        return ApiResponse<void>(
          success: false,
          message: data['message'] ?? '未知錯誤',
        );
      } else {
        return ApiResponse<void>(
          success: false,
          message: '未知錯誤: ${e.message}',
        );
      }
    } else {
      // 其他異常
      return ApiResponse<void>(
        success: false,
        message: '錯誤發生: $e',
      );
    }
  }
}
