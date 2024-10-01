import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/response/api_response.dart';

import 'package:qswait/services/api_service.dart';

Future<ApiResponse<void>> changeQueueStatus(int customerId, String queueStatus,
    {String numbmerStatus = ""}) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/updateQueueStatus',
      data: {
        "id": customerId,
        "queueStatus": queueStatus,
        "numberStatus": numbmerStatus
      },
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

Future<ApiResponse<void>> cancelQueue(int customerId) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/updateQueueStatus',
      data: {"id": customerId, "queueStatus": "Cancelled", "numberStatus": ""},
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

Future<ApiResponse<void>> changeToSeating(int customerId) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/updateQueueStatus',
      data: {
        "id": customerId,
        "queueStatus": "Seating",
        "numberStatus": "Seating"
      },
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

Future<ApiResponse<Customer>> callNumber(int customerId) async {
  try {
    final response = await apiService.post(
      '/Customer/queue/callNumber',
      data: {
        "id": customerId,
      },
    );

    if (response.data['success']) {
      final customerData = response.data['data'][0];
      Customer updatedCustomer = Customer.fromJson(customerData);
      return ApiResponse<Customer>(
        success: true,
        message: response.data['message'],
        data: updatedCustomer,
      );
    } else {
      return ApiResponse<Customer>(
        success: false,
        message: response.data['message'],
        data: null,
      );
    }
  } catch (e) {
    print('API call error: $e');
    return ApiResponse<Customer>(
      success: false,
      message: 'Error occurred: $e',
      data: null,
    );
  }
}
