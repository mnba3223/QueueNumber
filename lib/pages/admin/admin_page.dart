import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/admin/business_hour.dart';
import 'package:qswait/services/app_router.dart';

import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class AdminPage extends ConsumerStatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  int _selectedOption = 0;
  CancelToken? _cancelToken;

  final List<String> upperOptions = [
    "主選單",
    "基本設定",
    "接待項目",
    "等待項目/等待時間",
    "接待時間",
    // "QrCode設定",
  ];

  final List<PageRouteInfo> _pageRoutes = [
    MainSettingRoute(),
    BasicConfigRoute(),
    ReceptionItemRoute(),
    WaitingItemTimeSettingRoute(),
    WaitingTime(),
    // QrcodeSettingRoute(),
  ];

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(storeProvider.notifier)
          .fetchStoreInfo(cancelToken: _cancelToken);
      ref
          .read(categoryProvider.notifier)
          .fetchCategoriesFromApi(cancelToken: _cancelToken);
      // _checkForNewCustomerNotifications();
    });
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    super.dispose();
  }

  void _checkForNewCustomerNotifications() {
    final unnotifiedCustomerIds =
        ref.read(customerQueueProvider.notifier).unnotifiedCustomerIds;
    final store = ref.read(storeProvider).value;
    final notifyTheReceptionist = store?.notifyTheReceptionist == 'Y';

    if (unnotifiedCustomerIds.isNotEmpty && notifyTheReceptionist) {
      ref.read(customerQueueProvider.notifier).clearNewCustomerNotifications();
      showDialog(
        context: getIt<AppRouter>().navigatorKey.currentState!.context,
        builder: (context) => AlertDialog(
          title: Text('新客戶通知'),
          content: Text('有新的客戶加入了隊列。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double tabletWidth = MediaQuery.of(context).size.width * 0.3;
    final selectedMode = ref.watch(adminPageProvider);
    final store = ref.watch(storeProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForNewCustomerNotifications();
      // _checkForNewCustomerNotifications();
    });
    // final storeNotifier = ref.read(storeProvider.notifier);

    // final stopTakingNumbers = store.maybeWhen(
    //   data: (data) => data.stopTakingNumbers == 'N',
    //   orElse: () => false,
    // );

    final closeStore = store.maybeWhen(
      data: (data) => data.frontEndClosed == 'N',
      orElse: () => false,
    );
    final businessHoursTime = store.maybeWhen(
      data: (data) => data.businessHoursTime == 'Y',
      orElse: () => false,
    );
    final businessHours = ref.watch(businessHoursProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<int>(
              onSelected: (item) {
                if (item == 0) {
                  _showLogoutConfirmationDialog(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('登出'),
                ),
              ],
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    "${store.value?.storeId ?? ''}",
                    style: TextStyle(
                        fontSize: 5.sp, color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 10.sp),
                ],
              ),
            ),
          ],
          // title: Text("Admin"),
          leading: selectedMode != null
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (selectedMode == '店家模式') {
                      AutoRouter.of(context).replaceNamed('/multiple_merchant');
                    } else if (selectedMode == '顧客模式') {
                      (!closeStore ||
                              shouldStopTakingNumbers(
                                  businessHoursTime, businessHours))
                          // ? AutoRouter.of(context)
                          //     .replaceNamed('/customer_stop')
                          ? showCloseStore()
                          : AutoRouter.of(context).replaceNamed('/customer');
                    }
                  },
                )
              : null,
        ),
        drawerEnableOpenDragGesture: false,
        body: Row(
          children: [
            Container(
              width: tabletWidth,
              // color: Colors.grey[200],
              child: ListView(
                padding: EdgeInsets.only(left: 15, right: 15),
                children: upperOptions.map((option) {
                  int index = upperOptions.indexOf(option);
                  bool isSelected = _selectedOption == index;
                  return Column(
                    children: [
                      if (upperOptions.indexOf(option) == 0) headerWidget(),
                      Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor95
                              : Colors.transparent,
                          // border: isSelected
                          //     ? Border(
                          //         left: BorderSide(
                          //           color: AppColors.primaryColor,
                          //           width: 5,
                          //         ),
                          //       )
                          //     : null,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedOption = index;
                                  });
                                  // AutoRouter.of(context)
                                  //     .replace(_pageRoutes[index]);
                                  context.router.replace(_pageRoutes[index]);
                                },
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(option,
                                        style: isSelected
                                            ? Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.CommonText)
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: AppColors.CommonText)
                                        // style: TextStyle(
                                        //   fontWeight: isSelected
                                        //       ? FontWeight.bold
                                        //       : FontWeight.normal,
                                        //   color: isSelected
                                        //       ? AppColors.CommonText
                                        //       : Colors.black,
                                        // ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            // Divider(height: 1, thickness: 1.5),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Container(child: AutoRouter()),
            ),
          ],
        ),
      ),
    );
  }

  showCloseStore() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("關店中"),
          content: Text('目前已經關店'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        );
      },
    );
  }

  Widget headerWidget() {
    final store = ref.read(storeProvider).value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "${store?.storeName ?? ''}",
            style: TextStyle(
              fontSize: 8.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(height: MediaQuery.of(context).size.height * 0.1),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         child: Text(
  //           "取號、叫號設定",
  //           style: TextStyle(color: Colors.grey[400]),
  //         ),
  //       ),
  //       Divider(
  //         height: 2,
  //       )
  //     ],
  //   );
  // }
}

bool shouldStopTakingNumbers(
    bool businessHoursTime, List<BusinessHour> businessHours) {
  // final DateTime now = DateTime.now();
  final DateTime now = getCurrentTime();
  final bool isWithinBusinessHours = businessHours.any((hour) {
    final startTime = parseTime(hour.startTime);
    final endTime = parseTime(hour.endTime);
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    return isTimeWithinRange(currentTime, startTime, endTime);
  });
  log("目前是不是開店時間 : ${(businessHoursTime)} ${!isWithinBusinessHours}}");
  return (businessHoursTime && !isWithinBusinessHours);
}

Future<void> _logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  AutoRouter.of(context).pushAndPopUntil(LoginRoute(),
      predicate: (Route<dynamic> route) {
    return false;
  });
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('登出'),
      content: Text('您確定要登出嗎？'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _logout(context);
          },
          child: Text('確認'),
        ),
      ],
    ),
  );
}
