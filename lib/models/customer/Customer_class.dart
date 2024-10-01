// lib/models/customer.dart
import 'dart:developer';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qswait/services/api/customers_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';

part 'Customer_class.freezed.dart';
part 'Customer_class.g.dart';

///version 2
// @freezed
// class Customer with _$Customer {
//   const Customer._();

//   const factory Customer({
//     required int id,
//     required String number,
//     required String checkinType,
//     required String storeId,
//     required String time,
//     required String checkTime,
//     int? numberOfPeople,
//     int? numberOfChild,
//     String? email,
//     String? line,
//     required int checkinType,
//     required String checkinTypeName,
//     int? currentSort,
//     String? callingTime,
//     String? callingStatus,
//     required String queueStatus,
//     String? needs,
//   }) = _Customer;

//   factory Customer.fromJson(Map<String, dynamic> json) =>
//       _$CustomerFromJson(json);
// }
@freezed

///version3
class Customer with _$Customer {
  const Customer._();

  const factory Customer({
    required int id,
    required String number,
    required String queueNum,
    required String checkinType,
    required String storeId,
    required String time,
    required String checkTime,
    required int? queueType,
    int? numberOfPeople,
    int? numberOfChild,
    String? queueNumTitle,
    int? currentSort,
    String? callingTime,
    String? callingStatus,
    required String queueStatus,
    String? needs,
    required String queueTypeName,
    @JsonKey(ignore: true) bool? notifyNewCustomer, // 忽略从 JSON 中解析该属性
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}

class CurrentCustomerNotifier extends StateNotifier<Customer?> {
  Ref ref;
  CurrentCustomerNotifier(this.ref)
      : super(Customer(
          id: 0,
          number: "0",
          queueNum: "0",
          checkinType: "onsite",
          storeId: "",
          time: "",
          checkTime: "",
          numberOfPeople: 0, // 设置为可选类型
          numberOfChild: 0, // 设置为可选类型
          queueNumTitle: "A",
          queueStatus: "waiting",
          callingStatus: "notCalled",
          callingTime: "",
          queueType: 0,
          currentSort: 0,
          queueTypeName: "null",
          needs: "",
        )) {
    initialCustomer();
  }
  final Customer _initialCustomer = Customer(
    id: 0,
    number: "0",
    queueNum: "0",
    checkinType: "onsite",
    storeId: "",
    time: "",
    checkTime: "",
    numberOfPeople: 0, // 设置为可选类型
    numberOfChild: 0, // 设置为可选类型
    queueNumTitle: "A",
    queueStatus: "waiting",
    callingStatus: "notCalled",
    callingTime: "",
    queueType: 0,
    currentSort: 0,
    queueTypeName: "null",
    needs: "",
  );

  /// 初始化客户
  void initialCustomer({bool isCustomer = false}) {
    final store = ref.read(storeProvider).value;
    if (store != null) {
      final storeId = store.storeId;
      state = _initialCustomer.copyWith(numberOfPeople: isCustomer ? 1 : 0);
      state = _initialCustomer.copyWith(storeId: storeId);
    } else {
      log('You need to set storeId first');
    }
    // 初始化时的空客户
  }

  // 设置客户数据
  void setCustomer(Customer customer) {
    state = customer;
  }

  // 更新客户数据
  void updateCustomer(void Function(Customer) updates) {
    if (state != null) {
      updates(state!);
      state = state; // 触发更新
    }
  }

  // 清除当前客户，重置为初始客户
  void clearCustomer({bool isCustomer = false}) {
    final store = ref.read(storeProvider).value;
    if (store != null) {
      final storeId = store.storeId;

      state = _initialCustomer.copyWith(storeId: storeId);
    } else {
      log('You need to set storeId first');
    }
    state = _initialCustomer.copyWith(
        numberOfChild: isCustomer ? 1 : 0, numberOfPeople: isCustomer ? 1 : 0);
  }
}

/// 客戶對列資訊
class CustomerQueueInfo {
  final List<Customer> customers;
  final int averageProcessTimeInMinutes;

  CustomerQueueInfo({
    required this.customers,
    this.averageProcessTimeInMinutes = 5,
  });

  int get waitingGroups => customers.length;
  int get waitingTime => customers.length * averageProcessTimeInMinutes;
}

class CustomerQueue extends StateNotifier<CustomerQueueInfo> {
  final Ref ref;
  Set<int> _newCustomerIds = {}; // 保存客戶ID
  Set<int> get newCustomerIds => _newCustomerIds;
  List<int> _unnotifiedCustomerIds = []; // 用来保存未通知的新客户 ID
  List<int> get unnotifiedCustomerIds => _unnotifiedCustomerIds;
  CustomerQueue(this.ref) : super(CustomerQueueInfo(customers: []));

  void addCustomer(Customer customer) {
    state = CustomerQueueInfo(
      customers: [...state.customers, customer],
      averageProcessTimeInMinutes: state.averageProcessTimeInMinutes,
    );
  }

  void addCustomers(List<Customer> customers) {
    state = CustomerQueueInfo(
      customers: [...state.customers, ...customers],
      averageProcessTimeInMinutes: state.averageProcessTimeInMinutes,
    );
  }

  void updateCustomer(Customer updatedCustomer) {
    state = CustomerQueueInfo(
      customers: state.customers
          .map((customer) =>
              customer.id == updatedCustomer.id ? updatedCustomer : customer)
          .toList(),
      averageProcessTimeInMinutes: state.averageProcessTimeInMinutes,
    );
  }

  void setCustomers(List<Customer> customers) {
    state = CustomerQueueInfo(
      customers: [...customers],
      averageProcessTimeInMinutes: state.averageProcessTimeInMinutes,
    );
  }

  /// 从 API 获取所有客户数据
  Future<void> fetchCustomersFromApi({CancelToken? cancelToken}) async {
    final store = ref.read(storeProvider).value;
    if (store != null) {
      // final storeId = store.storeId;
      // final apiService = ref.read(apiServiceProvider);
      // final response = await fetchAllCustomers(apiService, storeId,
      //     cancelToken: cancelToken);

      // _checkForNewCustomers(response.data ?? []);
      // setCustomers(response.data ?? []);
      final mockCustomers = _generateMockCustomers();

      _checkForNewCustomers(mockCustomers);
      setCustomers(mockCustomers);
    } else {
      log('You need to set storeId first');
    }
  }

  List<Customer> _generateMockCustomers() {
    final random = math.Random();
    final customers = <Customer>[];
    final queueStatuses = [
      'waiting',
      'processing',
      'finished',
      'seating',
      'cancelled'
    ];
    final queueTypes = ['A', 'B', 'C', "D"];
    final queueTypesName = ['一般座位', '四人座', '六人座', "聚會"];
    for (int i = 0; i < 20; i++) {
      customers.add(
        Customer(
          id: i + 1,
          number: (i + 1).toString().padLeft(3, '0'),
          queueNum:
              "${queueTypes[random.nextInt(queueTypes.length)]}${(i + 1).toString().padLeft(3, '0')}",
          checkinType: random.nextBool() ? "onsite" : "web",
          storeId: "STORE001",
          time: DateTime.now()
              .subtract(Duration(minutes: random.nextInt(60)))
              .toIso8601String(),
          checkTime: DateTime.now().toIso8601String(),
          queueType: random.nextInt(3) + 1,
          numberOfPeople: random.nextInt(4) + 1,
          numberOfChild: random.nextInt(2),
          queueNumTitle: queueTypes[random.nextInt(queueTypes.length)],
          currentSort: i + 1,
          callingTime:
              random.nextBool() ? DateTime.now().toIso8601String() : null,
          callingStatus: random.nextBool() ? "called" : "notCalled",
          queueStatus: queueStatuses[random.nextInt(queueStatuses.length - 1)],
          queueTypeName:
              queueTypesName[random.nextInt(queueStatuses.length - 1)],
          needs: random.nextBool() ? "特殊需求" : null,
        ),
      );
    }
    // log("${customers}");
    return customers;
  }

//   void _checkForNewCustomers(List<Customer> newCustomers) {
//     final oldCustomerIds = state.customers.map((c) => c.id).toSet();
//     final newCustomerIds = newCustomers.map((c) => c.id).toSet();
//     final hasNewCustomers =
//         newCustomerIds.difference(oldCustomerIds).isNotEmpty;
//     final store = ref.read(storeProvider).value;
//     final notifyTheReceptionist = store?.notifyTheReceptionist == 'Y';
//     // getIt<AppRouter>().navigatorKey.currentState?.context.router.current.name;
//     if (hasNewCustomers && notifyTheReceptionist) {
//       final context = getIt<AppRouter>().navigatorKey.currentState?.context;
//       final currentRouteName = getIt<AppRouter>()
//           .navigatorKey
//           .currentState
//           ?.context
//           .router
//           .current
//           .name;
//       log(" now path name ${getIt<AppRouter>().navigatorKey.currentState?.context.router.current.name}");
//       final isRelevantPage = currentRouteName == 'AdminRoute' ||
//           currentRouteName == 'MerchantMultipleMainRoute';

//       if (isRelevantPage) {
//         showDialog(
//           context: context!,
//           builder: (context) => AlertDialog(
//             title: Text('新客戶通知'),
//             content: Text('有新的客戶加入了隊列。'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: Text('確定'),
//               ),
//             ],
//           ),
//         );
//       }
//     }
  // }
  void _checkForNewCustomers(List<Customer> newCustomers) {
    final oldCustomerIds = state.customers.map((c) => c.id).toSet();
    final newCustomerIds = newCustomers.map((c) => c.id).toSet();
    final newUnnotifiedCustomerIds = newCustomerIds.difference(oldCustomerIds);
    final store = ref.read(storeProvider).value;
    final notifyTheReceptionist = store?.notifyTheReceptionist == 'Y';

    if (newUnnotifiedCustomerIds.isNotEmpty && notifyTheReceptionist) {
      _unnotifiedCustomerIds.addAll(newUnnotifiedCustomerIds);
    }
  }

  void clearNewCustomerNotifications() {
    _unnotifiedCustomerIds.clear();
  }
}

/// 顧客頁面控制
class CustomerPageControl {
  final List<String> pages;
  final int currentIndex;

  CustomerPageControl({required this.pages, this.currentIndex = 0});

  // 获取当前页面
  String getCurrentPage() => pages[currentIndex];
  //獲取下一頁
  // String getNextPage() => pages[currentIndex + 1];
  String getNextPage() {
    if (hasNextPage()) {
      return pages[currentIndex + 1];
    } else {
      return pages[currentIndex]; // 或者返回一个默认的结束页
    }
  }

  //拿取特定頁面
  String getIndexPage(int index) => pages[index];

  // 判断是否有下一页
  bool hasNextPage() => currentIndex < pages.length - 1;

  // 判断是否有下下一页
  bool hasSkipNextPage() => currentIndex + 1 < pages.length - 1;

  // 判断是否有上一页
  bool hasPreviousPage() => currentIndex > 0;

  // 进入下一页
  CustomerPageControl nextPage() => hasNextPage()
      ? CustomerPageControl(pages: pages, currentIndex: currentIndex + 1)
      : this;

  // 返回上一页
  CustomerPageControl previousPage() => hasPreviousPage()
      ? CustomerPageControl(pages: pages, currentIndex: currentIndex - 1)
      : this;

  // 跳過下一頁
  CustomerPageControl skipNextPage() => hasSkipNextPage()
      ? CustomerPageControl(pages: pages, currentIndex: currentIndex + 2)
      : this;

  ///去最後一頁
  CustomerPageControl lastPage() {
    return CustomerPageControl(pages: pages, currentIndex: pages.length - 1);
  }

  ///去最後一頁
  CustomerPageControl firstPage() {
    return CustomerPageControl(pages: pages, currentIndex: 0);
  }

  // 设置新的页面列表并保持 currentIndex 有效
  CustomerPageControl updatePages(List<String> newPages) {
    int newIndex = currentIndex;
    if (currentIndex >= newPages.length) {
      newIndex = newPages.length - 1;
    }
    return CustomerPageControl(pages: newPages, currentIndex: newIndex);
  }
}
