import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'Store_class.freezed.dart';
part 'Store_class.g.dart';

// @freezed
// class Store with _$Store {
//   const factory Store({
//     required String id,
//     required String name,
//     required bool requiresNumberInput,
//     required bool requiresSeatSelection,
//     required bool requiresSpecialNote,
//     required bool showQueueInfo,
//     required List<String> seatOptions,
//   }) = _Store;

//   factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
// }
///
bool? _stringToBool(String? value) => value == 'Y' ? true : false;

String? _boolToString(bool? value) => value ?? false ? 'Y' : 'N';

@freezed
class Store with _$Store {
  const factory Store({
    required int id,

    ///ID

    required String storeId,

    ///店鋪名稱
    required String storeName,

    ///通知使用者
    String? contactUser,

    ///聯絡信箱
    String? contactEmail,

    ///聯絡電話
    String? contactPhone,

    ///店鋪地址
    String? storeAdd,

    ///開始時間
    String? openingTime,

    ///重置排隊編號時間
    String? resetQueueNumberTime,

    ///網路取號
    String? webGetNumber,

    ///人數
    String? numberOfPeople,

    ///使用筆記
    String? useNotepad,

    ///成人和兒童
    String? adultsAndChildren,

    ///自動取號
    String? autoTakeNumber,

    ///延長模式
    String? extendedMode,

    ///差對
    String? cuttingInLine,

    ///停止排隊 或者關店的意思
    String? stopTakingNumbers,

    ///前端關閉 停止一切東西?
    String? frontEndClosed,

    ///通知接待員
    String? notifyTheReceptionist,

    ///通知客戶取消
    String? notifyCustomerCancellation,

    ///接待聲音
    String? receptionSound,

    ///等待螢幕畫面
    String? screenSaver,

    ///排隊重置時間
    String? queueResetTime,

    /// 跳過確認頁面
    String? skipConfirmationScreen,

    ///顯示排隊警告
    String? showWaitingAlerts,

    ///排隊時間
    String? queueTimeSettingAll,

    ///顯示組數或人數開關

    String? showGroupsOrPeople,

    ///Y的話僅計算未呼叫人數
    // @JsonKey(fromJson: _stringToBool, toJson: _boolToString)
    String? useNoCallToCalculate,
    int? highlightOverTime,

    ///排隊時間
    int? queueTimeSettingAllWaitingTime,
    int? queueTimeSettingAllIntervalTime,

    /// action  "'earliest','last','total'" 顯示組數或人數
    String? allWaitingTimeDisplayed,

    ///等待時間
    String? businessHoursTime,

    ///顯示等待時間
    String? showWaitingTime,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

Store mockStore = Store(
  id: 1,
  storeId: "STORE001",
  storeName: "咖啡天地",
  contactUser: "張經理",
  contactEmail: "manager@coffeeheaven.com",
  contactPhone: "0912345678",
  storeAdd: "台北市中正區忠孝東路100號",
  openingTime: "09:00",
  resetQueueNumberTime: "00:00",
  webGetNumber: "Y",
  numberOfPeople: "Y",
  useNotepad: "Y",
  adultsAndChildren: "N",
  autoTakeNumber: "Y",
  extendedMode: "N",
  cuttingInLine: "N",
  stopTakingNumbers: "N",
  frontEndClosed: "N",
  notifyTheReceptionist: "Y",
  notifyCustomerCancellation: "Y",
  receptionSound: "default",
  screenSaver: "Y",
  queueResetTime: "23:59",
  skipConfirmationScreen: "N",
  showWaitingAlerts: "Y",
  queueTimeSettingAll: "30",
  showGroupsOrPeople: "groups",
  useNoCallToCalculate: "N",
  highlightOverTime: 15,
  queueTimeSettingAllWaitingTime: 20,
  queueTimeSettingAllIntervalTime: 5,
  allWaitingTimeDisplayed: "total",
  businessHoursTime: "09:00-21:00",
  showWaitingTime: "Y",
);

class StoreNotifier extends StateNotifier<AsyncValue<Store>> {
  StoreNotifier() : super(AsyncLoading()) {
    _initializeStore();
  }
  // 新增一個變數來保存 logo 數據
  Uint8List? _storeLogo;
  Uint8List? get storeLogo => _storeLogo;
  String? _storeId;
  String? get storeId => _storeId;

  Future<void> _initializeStore() async {
    final prefs = await SharedPreferences.getInstance();
    _storeId = prefs.getString('storeId');
    if (_storeId != null) {
      await fetchStoreInfo();
      await loadCachedStoreLogo();
    } else {
      // state = AsyncError("Store ID not found", StackTrace.current);
    }
  }

  Future<void> fetchStoreInfo({CancelToken? cancelToken}) async {
    // if (_storeId == null) {
    //   // state = AsyncError("Store ID not found", StackTrace.current);
    //   return;
    // }

    // try {
    // final response =
    //     await fetchStoreInfoFromApi(_storeId!, cancelToken: cancelToken);
    //   if (response.success && response.data?.isNotEmpty == true) {
    //     state = AsyncData(response.data!.first);
    //   } else {
    //     state = AsyncError(response.message, StackTrace.current);
    //   }
    // } catch (e) {
    //   state = AsyncError(e.toString(), StackTrace.current);
    //   print('Error fetching store info: $e');
    // }
    ///mock data
    state = AsyncData(mockStore);
  }

  Future<void> loadCachedStoreLogo() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedImageData = prefs.getString('storeLogo');
    if (cachedImageData != null) {
      _storeLogo = base64Decode(cachedImageData);
      state = state;
    } else {
      await fetchAndCacheStoreLogo();
    }
  }

  Future<void> fetchAndCacheStoreLogo() async {
    try {
      final response = await fetchStoreLogo(_storeId!);
      if (response.success && response.data != null) {
        final newImageData = response.data!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('storeLogo', newImageData);
        _storeLogo = base64Decode(newImageData);
        state = state;
      }
    } catch (e) {
      print('Error fetching store logo: $e');
    }
  }

  // Future<void> fetchStoreLogobySharedPreference() async {
  //   final storeId = _storeId;
  //   if (storeId == null) return;

  //   try {
  //     final response = await fetchStoreLogo(storeId);
  //     if (response.success) {
  //       final newImageData = response.data;
  //       final prefs = await SharedPreferences.getInstance();
  //       final cachedImageData = prefs.getString('storeLogo');
  //       // if (cachedImageData == null) {
  //       //   await prefs.setString('storeLogo', newImageData!);
  //       //   final decodedImage = base64Decode(newImageData);
  //       //   _storeLogo = decodedImage;
  //       //   state = state;
  //       //   return;
  //       // }
  //       if (cachedImageData != newImageData) {
  //         await prefs.setString('storeLogo', newImageData!);
  //         final decodedImage = base64Decode(newImageData);
  //         _storeLogo = decodedImage;
  //         state = state;
  //       } else {
  //         if (cachedImageData != null) {
  //           final decodedImage = base64Decode(cachedImageData);
  //           _storeLogo = decodedImage;
  //           state = state;
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching store logo: $e');
  //   }

  //   state = state; // 强制更新监听器
  // }

  void updateStore(Store newStore) {
    state = AsyncData(newStore);
  }

  void setStoreId(String storeId) async {
    _storeId = storeId;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('storeId', storeId);
    await fetchStoreInfo(); // 設置 storeId 後立即調用 fetchStoreInfo
  }

  AsyncValue<bool> isExtendedModeEnabled() {
    return state.whenData((store) => store.extendedMode == 'Y');
  }

  Future<void> updateStoreInApi(Store updatedStore) async {
    try {
      final response = await apiService.post(
        '/Merchant/updateStoreInfo',
        data: updatedStore.toJson(),
      );
      if (!response.success) {
        throw Exception('Failed to update store info');
      }
    } catch (e) {
      print('Error updating store info: $e');
    }
  }

  Future<void> updateModeSwitch(
      AdminModeAction action, String modeSwitchValue) async {
    // final storeId = state.value?.storeId ?? "";
    // 顯示等待對話框
    showDialog(
      context: getIt<AppRouter>().navigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    final response =
        await updateAdminModeSwitch(state.value, action, modeSwitchValue);
    if (response.success) {
      final updatedStore = state.value!.copyWith(
        numberOfPeople: action == AdminModeAction.numberOfPeople
            ? modeSwitchValue
            : state.value!.numberOfPeople,
        adultsAndChildren: action == AdminModeAction.adultsAndChildren
            ? modeSwitchValue
            : state.value!.adultsAndChildren,
        autoTakeNumber: action == AdminModeAction.autoTakeNumber
            ? modeSwitchValue
            : state.value!.autoTakeNumber,
        useNotepad: action == AdminModeAction.useNotepad
            ? modeSwitchValue
            : state.value!.useNotepad,
        showGroupsOrPeople: action == AdminModeAction.showGroupsOrPeople
            ? modeSwitchValue
            : state.value!.showGroupsOrPeople,
        useNoCallToCalculate: action == AdminModeAction.useNoCallToCalculate
            ? modeSwitchValue
            : state.value!.useNoCallToCalculate,
        allWaitingTimeDisplayed:
            action == AdminModeAction.allWaitingTimeDisplayed
                ? modeSwitchValue
                : state.value!.allWaitingTimeDisplayed,
        skipConfirmationScreen: action == AdminModeAction.skipConfirmationScreen
            ? modeSwitchValue
            : state.value!.skipConfirmationScreen,
        cuttingInLine: action == AdminModeAction.cuttingInLine
            ? modeSwitchValue
            : state.value!.cuttingInLine,
        stopTakingNumbers: action == AdminModeAction.stopTakingNumbers
            ? modeSwitchValue
            : state.value!.stopTakingNumbers,
        frontEndClosed: action == AdminModeAction.frontEndClosed
            ? modeSwitchValue
            : state.value!.frontEndClosed,
        businessHoursTime: action == AdminModeAction.businessHoursTime
            ? modeSwitchValue
            : state.value!.businessHoursTime,
        showWaitingTime: action == AdminModeAction.showWaitingTime
            ? modeSwitchValue
            : state.value!.showWaitingTime,
        notifyTheReceptionist: action == AdminModeAction.notifyTheReceptionist
            ? modeSwitchValue
            : state.value!.notifyTheReceptionist,
        screenSaver: action == AdminModeAction.screenSaver
            ? modeSwitchValue
            : state.value!.screenSaver,
        showWaitingAlerts: action == AdminModeAction.showWaitingAlerts
            ? modeSwitchValue
            : state.value!.showWaitingAlerts,
      );
      state = AsyncData(updatedStore);
    } else {
      // Handle error
      print('Error updating mode switch: ${response.message}');
    }
    // 隱藏等待對話框
    Navigator.of(getIt<AppRouter>().navigatorKey.currentState!.context).pop();
  }

  ///更新超出時間
  Future<void> updateAdminAboutTime(
      String updateTime, String updateAction) async {
    showDialog(
      context: getIt<AppRouter>().navigatorKey.currentState!.context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      final store = state.value;
      if (store == null) {
        throw Exception('Store not found');
      }
      final response = await apiService.post(
        '/Admin/updateAdminAboutTime',
        data: {
          "storeId": store.storeId,
          "updateTime": updateTime,
          "updateAction": updateAction,
          // "updatAction": updateAction,
        },
      );
      if (response.data['success']) {
        final updatedStore = state.value!.copyWith(
          highlightOverTime: int.tryParse(updateTime),
        );
        state = AsyncData(updatedStore);
      }

      // return <void>(
      //   success: response.data['success'],
      //   message: response.data['message'] ?? 'Update successful',
      // );
    } catch (e) {
      print('API call error: $e');
      // return ApiResponse<void>(
      //   success: false,
      //   message: 'Error occurred: $e',
      // );
    }
    Navigator.of(getIt<AppRouter>().navigatorKey.currentState!.context).pop();
  }
}
