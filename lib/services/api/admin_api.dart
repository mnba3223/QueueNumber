import 'package:dio/dio.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/models/admin/business_hour.dart';
import 'package:qswait/models/admin/store_text_screen.dart';
import 'package:qswait/models/response/api_response.dart';
import 'package:qswait/services/api_service.dart';

///拿取店家資料
Future<ApiResponse<List<Store>>> fetchStoreInfoFromApi(String? storeid,
    {CancelToken? cancelToken}) async {
  try {
    final response = await apiService.post(
      '/Merchant/getstoreInfo',
      data: {"storeId": storeid},
      cancelToken: cancelToken,
    );

    return ApiResponse.fromJsonList(response.data,
        (list) => list.map((json) => Store.fromJson(json)).toList());
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<List<Store>>(
      success: false,
      message: 'Error occurred: $e',
      data: [],
    );
  }
}

///切換對應模式
Future<ApiResponse<void>> updateExtendedMode(
    int storeId, bool extendedMode) async {
  try {
    final response = await apiService.post(
      '/Admin/adminExtendedMode',
      data: {
        "id": storeId,
        "extendedMode": extendedMode ? 'Y' : 'N',
      },
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? 'Update successful',
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<void>(
      success: false,
      message: 'Error occurred: $e',
    );
  }
}

/// 更新後台
// Future<ApiResponse<void>> updateAdminModeSwitch(
//     AdminModeSwitchRequest request) async {
//   try {
//     final response = await apiService.post(
//       '/Admin/adminModeSwitch',
//       data: request.toJson(),
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

/// admin 頁面的 切換模式api
// Future<ApiResponse<void>> updateAdminModeSwitch(
//     int storeId, AdminModeAction action, bool modeSwitch) async {
//   try {
//     final response = await apiService.post(
//       '/Admin/adminModeSwitch',
//       data: {
//         "id": storeId,
//         "storeId": "A001",
//         "action": action.name,
//         "modeSwitch": modeSwitch ? 'Y' : 'N',
//       },
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

Future<ApiResponse<void>> updateAdminModeSwitch(
    Store? store, AdminModeAction action, String modeSwitch) async {
  try {
    final response = await apiService.post(
      '/Admin/adminModeSwitch',
      data: {
        "id": store?.id ?? 0,
        "storeId": store?.storeId ?? "",
        "action": action.name,
        "modeSwitch": modeSwitch,
      },
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? 'Update successful',
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<void>(
      success: false,
      message: 'Error occurred: $e',
    );
  }
}

// Future<ApiResponse<void>> updateAdminAboutTime(
//     Store? store, String updateTime, String updateAction) async {
//   try {
//     // final store = state.data?.value;
//     if (store == null) {
//       throw Exception('Store not found');
//     }
//     final response = await apiService.post(
//       '/Admin/updateAdminAboutTime',
//       data: {
//         "storeId": store.storeId,
//         "updateTime": updateTime,
//         "updateAction": updateAction,
//       },
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

Future<ApiResponse<void>> validateBackendPassword(
    String storeId, String backendPassword) async {
  final requestData = {
    'storeId': storeId,
    'backendPassword': backendPassword,
  };
  // print('Request data: $requestData');
  try {
    final response = await apiService.post(
      '/Admin/adminBackstageLogin',
      data: requestData,
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? 'Update successful',
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<bool>(
      success: false,
      message: 'Error occurred: $e',
      data: false,
    );
  }
}

Future<ApiResponse<void>> editBackendPassword(
    String storeId, String backendPassword) async {
  final requestData = {
    'storeId': storeId,
    'backendPassword': backendPassword,
  };
  // print('Request data: $requestData');
  try {
    final response = await apiService.post(
      '/Admin/editBackendPassword',
      data: requestData,
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? 'Update successful',
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<bool>(
      success: false,
      message: 'Error occurred: $e',
      data: false,
    );
  }
}

Future<ApiResponse<String>> fetchStoreLogo(String? storeId) async {
  try {
    final response = await apiService.post(
      '/Admin/getStoreLogo',
      data: {
        'storeId': storeId,
      },
    );

    if (response.statusCode == 200 && response.data['success']) {
      final imageData = response.data['data'][0]['imageData'];
      return ApiResponse<String>(
          success: true, data: imageData, message: response.data['message']);
    } else {
      return ApiResponse<String>(
          success: false, message: response.data['message']);
    }
  } catch (e) {
    print('Error fetching store logo: $e');
    return ApiResponse<String>(
        success: false, message: 'Error fetching store logo');
  }
}

Future<ApiResponse<void>> updateReceptionHours(
    StoreReceptionHoursRequest request) async {
  try {
    final response = await apiService.post(
      '/Admin/storeReceptionHours',
      data: request.toJson(),
    );

    // Assuming the response has a 'success' field to indicate success
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'] ?? '操作成功',
    );
  } catch (e) {
    if (e is DioException) {
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
      return ApiResponse<void>(
        success: false,
        message: '錯誤發生: $e',
      );
    }
  }
}

Future<ApiResponse<StoreReceptionHoursRequest>> getStoreReceptionHours(
    String storeId) async {
  try {
    final response = await apiService.post(
      '/Admin/getStoreReceptionHours',
      data: {"storeId": storeId},
    );

    if (response.data['success']) {
      return ApiResponse<StoreReceptionHoursRequest>.fromJson(
        response.data,
        (json) => StoreReceptionHoursRequest.fromJson(json),
      );
    } else {
      return ApiResponse<StoreReceptionHoursRequest>(
        success: false,
        message: response.data['message'],
      );
    }
  } catch (e) {
    print('Error fetching store reception hours: $e');
    return ApiResponse<StoreReceptionHoursRequest>(
      success: false,
      message: 'Error fetching store reception hours',
    );
  }
}

Future<ApiResponse<StoreTextScreenResponse>> getStoreTextScreen(
    String storeId) async {
  try {
    final response = await apiService.post(
      '/Admin/getStoreTextScreen',
      data: {"storeId": storeId},
    );

    if (response.data['success']) {
      return ApiResponse<StoreTextScreenResponse>.fromJson(
        response.data,
        (json) => StoreTextScreenResponse.fromJson(json),
      );
    } else {
      return ApiResponse<StoreTextScreenResponse>(
        success: false,
        message: response.data['message'],
      );
    }
  } catch (e) {
    print('Error fetching store text screen: $e');
    return ApiResponse<StoreTextScreenResponse>(
      success: false,
      message: 'Error fetching store text screen',
    );
  }
}

Future<ApiResponse<void>> updateStoreTextScreen(
    StoreTextScreenResponse request) async {
  try {
    final response = await apiService.post(
      '/Admin/storeTextScreen',
      data: request.toJson(),
    );

    return response.data['success']
        ? ApiResponse<void>(success: true, message: '操作成功')
        : ApiResponse<void>(success: false, message: response.data['message']);
  } catch (e) {
    return ApiResponse<void>(
      success: false,
      message: 'Error updating store text screen: $e',
    );
  }
}
