import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/services/api/customers_api.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';

class NavigationHelper {
  final WidgetRef ref;
  final BuildContext context;

  NavigationHelper(this.ref, this.context);

  Future<void> navigateToNextPage({bool needCheckNumber = false}) async {
    final apiService = ref.read(apiServiceProvider);
    final customer = ref.read(currentCustomerProvider);
    final customerPageNotifier = ref.read(customerPageProvider.notifier);
    final store = ref.read(storeProvider);

    bool isOneClickMode = store.maybeWhen(
      data: (data) => data.autoTakeNumber == 'Y',
      orElse: () => false,
    );
    bool adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );
    bool showPeople = store.maybeWhen(
      data: (data) => data.numberOfPeople == 'N',
      orElse: () => false,
    );

    final categories = ref.read(categoryProvider).categories;

    // 检查是否只有一个选项
    List<int> enabledIndices = [];
    if (!showPeople) {
      enabledIndices.addAll(
        categories
            .asMap()
            .entries
            .where((entry) => entry.value.hideQueue)
            .map((entry) => entry.key)
            .toList(),
      );
      if (enabledIndices.isEmpty) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('注意'),
                content: Text('沒有符合的選項'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            });
        // showErrorDialog(, '請輸入符合人數的項目');
        return;
      }
    } else {
      for (int i = 0; i < categories.length; i++) {
        if (_isWithinRange(customer, categories[i], adultsAndChildren)) {
          enabledIndices.add(i);
        }
      }
    }
    // 显示加载对话框
    showLoadingDialog(context);
    try {
      // if (isOneClickMode) {
      //   // 如果是一键取票模式，直接跳到最后一页
      //   customerPageNotifier.toLastPage();
      //   // customer?.numberOfPeople = 1;
      //   final updateCustomer = customer?.copyWith(numberOfPeople: 1);
      //   handleAddCustomerAPI(customer: updateCustomer);

      // } else if (customerPageNotifier.hasNextPage()) {
      //   customerPageNotifier.toNextPage();
      //   Navigator.pop(context);
      //   context.router.pushNamed(customerPageNotifier.getCurrentPage());
      // } else {
      //   // 如果所有页面都已完成，先添加客户，再导航到最后检查页面
      //   handleAddCustomerAPI(customer: customer);
      // }
      // if (isOneClickMode) {
      //   // 如果是一键取票模式，直接跳到最后一页
      //   customerPageNotifier.toLastPage();
      //   final updateCustomer = customer?.copyWith(numberOfPeople: 0);
      //   handleAddCustomerAPI(customer: updateCustomer);
      // } else {
      // if (showNumberOfPeople) {
      //   // customerPageNotifier.removePage("/number_input");
      //   customerPageNotifier
      //       .setPages(["/customer", "/additional_category_items"]);
      // }
      // if (adultsAndChildren) {
      //   // if (!customerPageNotifier.containsPage("/child_number_input")) {
      //   //   customerPageNotifier.addPageAfter(
      //   //       "/number_input", "/child_number_input");
      //   // }
      //   customerPageNotifier.setPages([
      //     "/customer",
      //     "/number_input",
      //     "/child_number_input",
      //     "/additional_category_items"
      //   ]);
      // } else {
      //   customerPageNotifier.removePage("/child_number_input");
      // }
      if (needCheckNumber && enabledIndices.length == 0) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('注意'),
                content: Text('⽬前您輸入的⼈數較多，請直接詢問現場服務⼈員以便進⾏座位安排'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            });
        // showErrorDialog(, '請輸入符合人數的項目');
        return;
      }
      log("customerPageNotifier.getCurrentPage() ${customerPageNotifier.getNextPage()}");
      if (customerPageNotifier.getNextPage() == '/additional_category_items' &&
          isOneClickMode &&
          enabledIndices.length == 1) {
        log("skip addditional");
        // 自动跳过additional_category_items并执行handleAddCustomerAPI
        final selectedCategory = categories[enabledIndices.first];
        ref.read(currentCustomerProvider.notifier).setCustomer(
              customer!.copyWith(queueType: selectedCategory.queueType),
            );
        handleAddCustomerAPI(customer: customer);
      } else if (customerPageNotifier.hasNextPage()) {
        log("has next pages");
        customerPageNotifier.toNextPage();
        Navigator.pop(context);
        context.router.pushNamed(customerPageNotifier.getCurrentPage());
      } else {
        // 如果所有页面都已完成，先添加客户，再导航到最后检查页面
        handleAddCustomerAPI(customer: customer);
      }
      // }
    } catch (e) {
      Navigator.pop(context); // 关闭加载对话框
      showErrorDialog(context, 'Error occurred: $e');
    }
  }

  Future<void> handleAddCustomerAPI({Customer? customer}) async {
    // 如果所有页面都已完成，先添加客户，再导航到最后检查页面
    final response = await addCustomer(customer!);
    Navigator.pop(context);
    if (response.isSuccess) {
      ///去結算頁面。

      ref
          .read(currentCustomerProvider.notifier)
          .setCustomer(response.data ?? customer);

      context.router.push(FinalCheck(customer: response?.data ?? customer));
    } else {
      showErrorDialog(context, response.message);
    }
  }

  void navigateToPreviousPage() {
    final customerPageNotifier = ref.read(customerPageProvider.notifier);
    if (customerPageNotifier.hasPreviousPage()) {
      customerPageNotifier.toPreviousPage();
      Navigator.of(context).pop();
    }
  }

  ///跳過下一頁
  void navigateToNextPageSkip() {
    final customerPageNotifier = ref.read(customerPageProvider.notifier);
    if (customerPageNotifier.hasNextPage()) {
      customerPageNotifier.toNextPage();
      Navigator.of(context).pop();
    }
  }

  ///去最後一頁
  void navigateToLastPage() {
    final customerPageNotifier = ref.read(customerPageProvider.notifier);

    customerPageNotifier.toLastPage();
  }

  void navigatetoFirstPage() {
    final customerPageNotifier = ref.read(customerPageProvider.notifier);

    customerPageNotifier.toFirstPage();
  }

  // 显示加载对话框
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  // 显示错误消息对话框
  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isWithinRange(
      Customer? customer, Category category, bool adultsAndChildren) {
    if (customer == null) return false;
    final numberOfPeople = customer.numberOfPeople ?? 0;
    final totalPeople = adultsAndChildren
        ? numberOfPeople + (customer.numberOfChild ?? 0)
        : numberOfPeople;
    return totalPeople >= category.queuePeopleMin &&
        (category.queuePeopleMax == 0 ||
            totalPeople <= category.queuePeopleMax) &&
        category.hideQueue;
  }
}
