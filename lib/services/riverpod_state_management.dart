// state_management.dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/business_hour.dart';
import 'package:qswait/models/admin/store_text_screen.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/state/refreshNotifier.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/environment.dart';

///fake data
final initialQueue = CustomerQueueInfo(customers: [
  Customer(
    id: 1,
    number: "1",
    queueNum: "A01",
    checkinType: "onsite",
    storeId: "A001",
    time: "2024/5/21 上午 11:34:16",
    checkTime: "2024/5/21 上午 11:34:16",
    numberOfPeople: 2,
    numberOfChild: 0,
    queueNumTitle: "A",
    queueStatus: "waiting",
    callingStatus: "notCalled",
    callingTime: "",
    queueType: 0,
    currentSort: 1,
    queueTypeName: "雙人座",
    needs: "Near window",
  ),
  Customer(
    id: 2,
    number: "2",
    queueNum: "B02",
    checkinType: "onsite",
    storeId: "A001",
    time: "2024/5/21 上午 11:36:16",
    checkTime: "2024/5/21 上午 11:36:16",
    numberOfPeople: 4,
    numberOfChild: 1,
    queueNumTitle: "B",
    queueStatus: "waiting",
    callingStatus: "notCalled",
    callingTime: "",
    queueType: 1,
    currentSort: 2,
    queueTypeName: "四人座",
    needs: "Near door",
  ),
  Customer(
    id: 3,
    number: "3",
    queueNum: "C03",
    checkinType: "onsite",
    storeId: "A001",
    time: "2024/5/21 上午 11:38:16",
    checkTime: "2024/5/21 上午 11:38:16",
    numberOfPeople: 6,
    numberOfChild: 2,
    queueNumTitle: "C",
    queueStatus: "waiting",
    callingStatus: "notCalled",
    callingTime: "",
    queueType: 2,
    currentSort: 3,
    queueTypeName: "六人座",
    needs: "Away from window",
  ),
], averageProcessTimeInMinutes: 5 // predicted time in minutes
    );

// final customerQueueProvider = StateProvider<CustomerQueueInfo>((ref) {
//   return initialQueue;
// });

final apiServiceProvider = Provider<ApiService>((ref) {
  // print(LunchEnvironment.baseUrl);
  return ApiService(LunchEnvironment.baseUrl);
});

final currentNumberProvider = StateProvider<int>((ref) => 0);
final selectedIndexProvider = StateProvider<int>((ref) => 0);

final currentCustomerProvider =
    StateNotifierProvider<CurrentCustomerNotifier, Customer?>((ref) {
  return CurrentCustomerNotifier(ref)..initialCustomer();
});

final customerQueueProvider =
    StateNotifierProvider<CustomerQueue, CustomerQueueInfo>((ref) {
  return CustomerQueue(ref)..addCustomers(initialQueue.customers);
});
void addCustomerToQueue(WidgetRef ref, Customer customer) {
  ref.read(customerQueueProvider.notifier).addCustomer(customer);
  ref.read(currentCustomerProvider.notifier).clearCustomer(); // 清理当前顾客数据
}

///頁面控制狀態
class CustomerPageNotifier extends StateNotifier<CustomerPageControl> {
  ///暫時的資料
  CustomerPageNotifier()
      : super(CustomerPageControl(pages: [
          "/customer",
          "/number_input",
          "/additional_category_items"
        ]));

  void setPages(List<String> pages) {
    // state = CustomerPageControl(
    //   pages: pages,
    // );
    state = state.updatePages(pages);
  }

  void toNextPage() {
    state = state.nextPage();
  }

  void toPreviousPage() {
    state = state.previousPage();
  }

  void toSkipNextPage() {
    state = state.skipNextPage();
  }

  void toLastPage() {
    state = state.lastPage();
  }

  void toFirstPage() {
    state = state.firstPage();
  }

  void addPage(String page) {
    final updatedPages = List<String>.from(state.pages)..add(page);
    setPages(updatedPages);
  }

  void addPageAfter(String targetPage, String newPage) {
    final updatedPages = List<String>.from(state.pages);
    final targetIndex = updatedPages.indexOf(targetPage);
    if (targetIndex != -1) {
      updatedPages.insert(targetIndex + 1, newPage);
      setPages(updatedPages);
    }
  }

  bool containsPage(String page) {
    return state.pages.contains(page);
  }

  void removePage(String page) {
    final updatedPages = List<String>.from(state.pages)..remove(page);
    setPages(updatedPages);
  }

  void resetPages() {
    // 重置状态到初始状态
    state = CustomerPageControl(
        pages: ["/customer", "/number_input", "/additional_category_items"],
        currentIndex: 0);
  }

  bool hasNextPage() => state.hasNextPage();
  bool hasPreviousPage() => state.hasPreviousPage();
  bool hasSkipNextPage() => state.hasSkipNextPage();
  String getCurrentPage() => state.getCurrentPage();
  String getNextPage() => state.getNextPage();
  // void resetPages () => state = state.resetPages();
}

///
final customerPageProvider =
    StateNotifierProvider<CustomerPageNotifier, CustomerPageControl>((ref) {
  return CustomerPageNotifier();
});

///admin
// Riverpod 状态提供者
final storeProvider =
    StateNotifierProvider<StoreNotifier, AsyncValue<Store>>((ref) {
  return StoreNotifier();
});

///分類狀態控制
final categoryProvider =
    StateNotifierProvider<CategoryQueue, CategoryQueueInfo>((ref) {
  return CategoryQueue(ref);
});

// final customerQueueProvider_v2 = FutureProvider<List<Customer>>((ref) async {
//   final apiService = ref.read(apiServiceProvider);
//   final response = await apiService
//       .post('/Customer/queue/getAllQueueInfo', data: {"storeId": "A001"});
//   final List<dynamic> data = response.data['data'];
//   return data.map((json) => Customer.fromJson(json)).toList();
// });

// final categoryProvider_v2 = FutureProvider<List<Category>>((ref) async {
//   final apiService = ref.read(apiServiceProvider);
//   final response = await apiService
//       .post('/Customer/queue/getAllQueueInfo', data: {"storeId": "A001"});
//   final List<dynamic> data = response.data['data'];
//   return data.map((json) => Category.fromJson(json)).toList();
// });

///設定定時更新
// void startDataRefresh(WidgetRef ref) {
//   const duration = Duration(seconds: 10);
//   Timer.periodic(duration, (Timer timer) async {
//     // Update customer queue data
//     ref.read(customerQueueProvider.notifier).fetchCustomersFromApi(ref);

//     // Update store data
//     ref.read(storeProvider.notifier).fetchStoreInfo(ref);

//     // Update category data
//     ref.read(categoryProvider.notifier).fetchCategoriesFromApi(ref);
//   });
// }
final refreshProvider = StateNotifierProvider<RefreshNotifier, bool>((ref) {
  return RefreshNotifier();
});

final adminPageProvider =
    StateNotifierProvider<AdminPageNotifier, String?>((ref) {
  return AdminPageNotifier();
});

class AdminPageNotifier extends StateNotifier<String?> {
  AdminPageNotifier() : super(null);

  void setSelectedMode(String mode) {
    state = mode;
  }
}
// void updateModeSwitchExample() async {
//   final storeNotifier = ref.read(storeProvider.notifier);
//   await storeNotifier.updateModeSwitch(AdminModeAction.numberOfPeople, true);
//   await storeNotifier.updateModeSwitch(AdminModeAction.adultsAndChildren, false);
//   await storeNotifier.updateModeSwitch(AdminModeAction.autoTakeNumber, true);
// }

final businessHoursProvider =
    StateNotifierProvider<BusinessHoursNotifier, List<BusinessHour>>((ref) {
  return BusinessHoursNotifier();
});

final storeTextScreenProvider = StateNotifierProvider<StoreTextScreenNotifier,
    AsyncValue<StoreTextScreenResponse>>((ref) {
  return StoreTextScreenNotifier();
});
