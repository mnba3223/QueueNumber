import 'package:qswait/services/api_service.dart';

Future<void> testApi(ApiService apiService) async {
  try {
    // 使用相对路径来获取数据
    var response = await apiService.get('/TestApi');

    // 打印API返回的字串
    print('Response: ${response.data}');
  } catch (e) {
    // 处理错误
    print('API call error: $e');
  }
}

Future<void> greetApi(ApiService apiService) async {
  try {
    // 使用相对路径来获取数据
    var response = await apiService.get('/TestApi/greeting');

    // 打印API返回的字串
    print('Response: ${response.data}');
  } catch (e) {
    // 处理错误
    print('API call error: $e');
  }
}

// Future<List<Customer>> fetchAllCustomers(ApiService apiService) async {
//   try {
//     final response = await apiService.get('/customers');
//     final List<dynamic> data = response.data;

//     // 将 JSON 数据转换为 Customer 对象列表
//     return data.map((json) => Customer.fromJson(json)).toList();
//   } catch (e) {
//     print('API call error: $e');
//     return [];
//   }
// }
