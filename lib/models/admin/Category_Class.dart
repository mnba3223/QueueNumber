import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qswait/services/api/merchant.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/widgets/dialog.dart';
part 'Category_Class.freezed.dart';
part 'Category_Class.g.dart';

///注意 Y跟N是相反轉換
bool _stringToBool(String value) => value == 'Y' ? false : true;

String _boolToString(bool value) => value ? 'N' : 'Y';

@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String storeId,
    required int queueType,
    required String queueTypeName,
    required int queuePeopleMin,
    required int queuePeopleMax,
    required String queueNumTitle,
    required int defaultQueue,
    required int waitingTime,
    required int intervalTime,
    @JsonKey(fromJson: _stringToBool, toJson: _boolToString)
    required bool hideQueue,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

// 假資料
final categories = [
  Category(
      id: 1,
      storeId: "STORE001",
      queueType: 0,
      queueTypeName: "一般座位",
      queuePeopleMin: 1,
      queuePeopleMax: 2,
      queueNumTitle: "A",
      defaultQueue: 0,
      waitingTime: 5,
      intervalTime: 10,
      hideQueue: false),
  Category(
      id: 2,
      storeId: "STORE001",
      queueType: 1,
      queueTypeName: "四人座",
      queuePeopleMin: 3,
      queuePeopleMax: 4,
      queueNumTitle: "B",
      defaultQueue: 1,
      waitingTime: 5,
      intervalTime: 10,
      hideQueue: true),
  Category(
      id: 3,
      storeId: "STORE001",
      queueType: 2,
      queueTypeName: "六人座",
      queuePeopleMin: 5,
      queuePeopleMax: 6,
      queueNumTitle: "C",
      defaultQueue: 0,
      waitingTime: 5,
      intervalTime: 10,
      hideQueue: true),
  Category(
      id: 4,
      storeId: "STORE001",
      queueType: 3,
      queueTypeName: "聚會",
      queuePeopleMin: 7,
      queuePeopleMax: 0,
      queueNumTitle: "D",
      defaultQueue: 0,
      waitingTime: 5,
      intervalTime: 10,
      hideQueue: false),
];

class CategoryQueueInfo {
  final List<Category> categories;

  CategoryQueueInfo({required this.categories});
}

class CategoryQueue extends StateNotifier<CategoryQueueInfo> {
  final Ref ref;
  CategoryQueue(this.ref) : super(CategoryQueueInfo(categories: []));

  void addCategory(Category category) {
    state = CategoryQueueInfo(
      categories: [...state.categories, category],
    );
  }

  void addCategories(List<Category> categories) {
    state = CategoryQueueInfo(
      categories: [...state.categories, ...categories],
    );
  }

  void updateCategory(Category updatedCategory) {
    state = CategoryQueueInfo(
      categories: state.categories
          .map((category) =>
              category.id == updatedCategory.id ? updatedCategory : category)
          .toList(),
    );
  }

  Future<void> updateCategoryByApi(
      BuildContext context, Category updatedCategory) async {
    showLoadingDialog(context);
    final response = await updateCategoryAPI(updatedCategory, "update");

    if (response.success) {
      state = CategoryQueueInfo(
        categories: state.categories
            .map((category) =>
                category.id == updatedCategory.id ? updatedCategory : category)
            .toList(),
      );
      fetchCategoriesFromApi();
      hideLoadingDialog(context);
    } else {
      hideLoadingDialog(context);

      ///pop  dialog error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('更新失敗'),
            content: Text(
                "${response.message == "Invalid action value or queue type have waiting" ? "尚有組別在排隊中，所以無法編輯與刪除" : response.message}"),
            actions: <Widget>[
              TextButton(
                child: Text('確定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void setCategories(List<Category> categories) {
    state = CategoryQueueInfo(
      categories: [...categories],
    );
  }

  Future<void> fetchCategoriesFromApi({CancelToken? cancelToken}) async {
    final storeId = ref.read(storeProvider.notifier).state.valueOrNull?.storeId;
    if (storeId != null) {
      // final response =
      //     await fetchAllCategories(storeId, cancelToken: cancelToken);
      // setCategories(response.data ?? []);
      setCategories(categories);
    } else {
      log("you need to set storeId first");
      // Handle the case when storeId is null, if necessary
    }
    // ref.read(categoryProvider.notifier).setCategories(response.data ?? []);
  }
}
