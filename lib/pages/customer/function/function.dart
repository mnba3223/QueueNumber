import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/services/riverpod_state_management.dart';

void updateCustomerPages(WidgetRef ref) {
  final store = ref.watch(storeProvider);
  final customerPageNotifier = ref.read(customerPageProvider.notifier);

  ///顯示人數
  bool showNumberOfPeople = store.maybeWhen(
    data: (data) => data.numberOfPeople == 'N',
    orElse: () => false,
  );

  ///顯示大人小孩
  bool adultsAndChildren = store.maybeWhen(
    data: (data) => data.adultsAndChildren == 'Y',
    orElse: () => false,
  );

  ///顯示筆記
  bool showNotePad = store.maybeWhen(
    data: (data) => data.useNotepad == 'Y',
    orElse: () => false,
  );

  ///跳過確認框開關 注意是關掉開關才是跳過
  final skipConfirmationScreen = store.maybeWhen(
    data: (data) => data.skipConfirmationScreen == 'N',
    orElse: () => false,
  );

  // 清空页面路径列表
  List<String> pages = [];

  // 添加初始页面
  pages.add("/customer");

  // List<String> pages = ["/customer"];
  if (showNumberOfPeople) {
    pages.add("/number_input");
    if (adultsAndChildren) {
      pages.add("/child_number_input");
    }
  }

  pages.add("/additional_category_items");

  if (showNotePad) {
    pages.add("/special_note");
  }
  if (skipConfirmationScreen) {
    pages.add("/customer_confirm");
  }
  customerPageNotifier.setPages(pages);
  log("pages : ${customerPageNotifier.state.pages} index : ${customerPageNotifier.state.currentIndex}");
}
