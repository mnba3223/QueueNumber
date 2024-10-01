import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/response/api_response.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/riverpod_state_management.dart';

Future<void> fetchCustomersFromApi(WidgetRef ref, String storeId,
    {CancelToken? cancelToken}) async {
  // // greetApi(apiService);
  // // fetchQueueInfo();
  // // use shoper ID and get customers
  // final customers = await fetchAllCustomers(apiService, "A001");

  // // 更新 Riverpod 状态
  // ref.read(customerQueueProvider.notifier).setCustomers(customers.data ?? []);

  final effectiveCancelToken = cancelToken ?? CancelToken();
  try {
    final customers = await fetchAllCustomers(apiService, storeId,
        cancelToken: effectiveCancelToken);

    if (!effectiveCancelToken.isCancelled) {
      ref
          .read(customerQueueProvider.notifier)
          .setCustomers(customers.data ?? []);
    }
  } catch (e) {
    if (!effectiveCancelToken.isCancelled) {
      print('Error fetching customers: $e');
    }
  }
}

// Future<List<Customer>> fetchAllCustomers(ApiService apiService) async {
//   try {
//     final response = await apiService.get('/Qwait/queue/QueueInfo/A001');
//     final List<dynamic> data = response.data;

//     // 将 JSON 数据转换为 Customer 对象列表
//     return data.map((json) => Customer.fromJson(json)).toList();
//   } catch (e) {
//     print('API call error: $e');
//     return [];
//   }
// }
/// post fetchAllCustomers API
Future<ApiResponse<List<Customer>>> fetchAllCustomers(
    ApiService apiService, String storeId,
    {CancelToken? cancelToken}) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/getAllQueueInfo',
      data: {"storeId": storeId},
      // cancelToken: cancelToken,
    );

    return ApiResponse.fromJsonList(response.data,
        (list) => list.map((json) => Customer.fromJson(json)).toList());
  } catch (e) {
    if (e is DioException && CancelToken.isCancel(e)) {
      print('Request canceled: $e');
    } else {
      print('API call error: $e');
    }
    return ApiResponse<List<Customer>>(
      success: false,
      message: 'Error occurred: $e',
      data: [],
    );
  }
}

Future<ApiResponse<Customer>> addCustomer(Customer customer) async {
  final requestData = customer.toJson();
  // print('Request data: $requestData');
  try {
    // 使用 POST 请求，将 customer 数据传递到服务器
    final response = await apiService.post(
      '/Customer/queue/getQueueInfo',
      data: customer.toJson(),
    );
    //  return ApiResponse.fromJsonList(response.data,
    //     (list) => list.map((json) => Customer.fromJson(json)).toList());
    return ApiResponse.fromJson(
        response.data, (json) => Customer.fromJson(json));
    // 如果 API 响应中没有数据，直接构建成功的 ApiResponse<void>
    // return ApiResponse<Customer>(
    //   success: true,
    //   message: 'Request successful',
    //   data: null, // 没有具体的数据要返回
    // );
  } catch (e) {
    // 捕获异常，返回失败的 ApiResponse<void>
    print('API call error: $e');
    return ApiResponse<Customer>(
      success: false,
      message: 'Error occurred: $e',
      data: null,
    );
  }
}

Future<ApiResponse<void>> editCustomerData(Customer customer) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/editCustomerData',
      data: customer.toJson(),
    );
    return ApiResponse<void>(
      success: true,
      message: 'Request successful',
      data: null,
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<void>(
      success: false,
      message: 'Error occurred: $e',
      data: null,
    );
  }
}

Future<ApiResponse<void>> updateCustomerInfo(Customer customer) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/updateSeatAndPeople',
      data: customer.toJson(),
      //  {
      //   "id": customer.id,
      //   "queueType": customer.queueType,
      //   "numberOfPeople": customer.numberOfPeople,
      // },
    );
    return ApiResponse<void>(
      success: response.data['success'],
      message: response.data['message'],
    );
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<void>(
      success: false,
      message: 'Error occurred: $e',
    );
  }
}

// Future<List<Customer>> fetchAllCustomers(ApiService apiService) async {
//   try {
//     // 确保路径正确并符合服务器端 API
//     final path = '/Qwait/queue/QueueInfo/A001';

//     // 使用 POST 请求发送数据，可以根据实际需要传递参数
//     final response = await apiService.post<Map<String, dynamic>>(
//       path,
//       {}, // 这里传递一个空的请求体（如果服务器要求请求体，通常传递一个空对象）
//     );

//     // 确保返回的响应数据类型正确
//     if (response != null && response.containsKey('customers')) {
//       final List<dynamic> responseData = response['customers'] as List<dynamic>;
//       // 解析 JSON 列表，将其转换为 Customer 对象列表
//       return responseData.map((json) => Customer.fromJson(json)).toList();
//     } else {
//       print('No customer data received.');
//       return [];
//     }
//   } catch (e) {
//     print('API call error: $e');
//     return [];
//   }
// }

// Future<void> greetApi(ApiService apiService) async {
//   try {
//     // 使用相对路径来获取数据
//     var response = await apiService.post('/api/TestApi',);

//     // 打印API返回的字串
//     print('Response: ${response.data}');
//   } catch (e) {
//     // 处理错误
//     print('API call error: $e');
//   }
// }
