import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/pages/customer/function/function.dart';
import 'package:qswait/pages/customer/widgets/iconBackground.dart';
import 'package:qswait/pages/marchant/widget/store_logo_page.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/app_router.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';
import 'package:qswait/widgets/UI.dart';
import 'package:qswait/widgets/num_pad/numeric_pad.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:math' as math;

@RoutePage()
class Customer_multiple_category_page extends ConsumerStatefulWidget {
  const Customer_multiple_category_page({super.key});

  @override
  ConsumerState<Customer_multiple_category_page> createState() =>
      _Customer_multiple_category_pageState();
}

class _Customer_multiple_category_pageState
    extends ConsumerState<Customer_multiple_category_page> {
  Timer? _screenSaverTimer;
  bool _showScreenSaver = false;
  String _screenSaverText = "";
  bool _isDialogShown = false; // Track if the dialog is already shown
  Map<String, List<Customer>> groupedCustomers = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(customerQueueProvider.notifier).fetchCustomersFromApi(ref);
      // ref.read(categoryProvider.notifier).fetchCategoriesFromApi();
      // ref.read(storeProvider.notifier).fetchStoreInfo(ref);
      ref.read(refreshProvider.notifier).refreshData(ref);
      updateCustomerPages(ref); // 初始化时设置页面路径
      // _loadStoreTextScreen();
      _checkScreenSaver();
    });
  }

  @override
  void dispose() {
    _screenSaverTimer?.cancel();
    _showScreenSaver = false;
    super.dispose();
  }

  Future<void> _loadStoreTextScreen() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    await ref
        .read(storeTextScreenProvider.notifier)
        .fetchStoreTextScreen(storeId);
  }

  void _checkScreenSaver() {
    final storeData = ref.read(storeProvider).value;
    if (storeData != null && storeData.screenSaver == 'Y') {
      _startScreenSaverTimer();
    }
  }

  void _startScreenSaverTimer() {
    _screenSaverTimer?.cancel();
    _screenSaverTimer = Timer(Duration(seconds: 30), () {
      _showScreenSaver = true;
      _showScreenSaverDialog();
      _startScreenSaverTimer();
      log("Screen saver started");
      setState(() {});
    });
  }

  void _resetScreenSaverTimer() {
    _showScreenSaver = false;
    _screenSaverTimer?.cancel();
    _startScreenSaverTimer();
    log("Screen saver reset");
    setState(() {});
  }

  void _setScreenSaverText() {
    final storeTextScreen = ref.read(storeTextScreenProvider).maybeWhen(
          data: (data) => data,
          orElse: () => null,
        );
    if (storeTextScreen != null) {
      _screenSaverText = storeTextScreen.noOneQueuing; // 这里根据需要设置文字
    }
  }

  void _showScreenSaverDialog() {
    final categoryInfo = ref.watch(categoryProvider);
    if (_isDialogShown) return;

    _isDialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final storeTextScreen = ref.watch(storeTextScreenProvider);
        final store = ref.watch(storeProvider).maybeWhen(
              data: (storeData) => storeData,
              orElse: () => null,
            );

        String screenSaverText = "Loading...";
        String waitingText = "Loading...";

        storeTextScreen.maybeWhen(
          data: (data) {
            // 根據具體條件設置屏保文字
            bool hasWaitingCustomers = groupedCustomers.values.any(
                (customers) => customers
                    .any((customer) => customer.queueStatus == 'waiting'));
            if (store?.stopTakingNumbers == "Y") {
              screenSaverText = data.stopTakeNumber;
            } else {
              if (hasWaitingCustomers) {
                screenSaverText = data.someOneQueuing; // 有人在排隊
              } else {
                screenSaverText = data.noOneQueuing; // 沒有人排隊
              }
            }
          },
          orElse: () => screenSaverText = "Loading...",
        );
        if (mounted) {
          return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                _resetScreenSaverTimer();
                Navigator.of(context).pop();
                _isDialogShown = false;
              },
              child: Container(
                color: AppColors.primaryColor,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        store?.storeName ?? 'Store Name',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        "歡迎光臨",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                    // SizedBox(height: 50),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "$screenSaverText",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // SizedBox(height: 50),
                    Expanded(
                      // flex: 2,
                      child: buildWaitingInfoForDialog(
                        context,
                        categoryInfo.categories
                            .where((category) => category.hideQueue)
                            .toList(),
                        groupedCustomers,
                        store?.showGroupsOrPeople,
                        store?.allWaitingTimeDisplayed,
                      ),
                    ),
                    Spacer(),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   // child: StoreLogoPage(),
                    //   child: buildLogoWidget(ref),
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  int _getWaitingGroupsCount() {
    return groupedCustomers.values.fold<int>(
      0,
      (sum, customers) =>
          sum + customers.where((c) => c.queueStatus == 'waiting').length,
    );
  }

  int _getWaitingPeopleCount() {
    return groupedCustomers.values.fold<int>(
      0,
      (sum, customers) =>
          sum +
          customers.where((c) => c.queueStatus == 'waiting').fold<int>(
              0,
              (subSum, c) =>
                  subSum + (c.numberOfPeople ?? 0) + (c.numberOfChild ?? 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queueInfo = ref.watch(customerQueueProvider);
    final categoryInfo = ref.watch(categoryProvider);
    final store = ref.watch(storeProvider);

    log("build customer view $queueInfo  $categoryInfo  $store ");

    // Initialize the groupedCustomers map with categories' queueNumTitle
    for (var category in categoryInfo.categories) {
      groupedCustomers[category.queueNumTitle] = [];
    }
    ref.listen(storeProvider, (_, __) {
      updateCustomerPages(ref); // store 变化时重新设置页面路径
    });
    // Group customers by their queueNumTitle
    for (var customer in queueInfo.customers) {
      if (customer.queueNumTitle != null) {
        if (groupedCustomers.containsKey(customer.queueNumTitle!)) {
          groupedCustomers[customer.queueNumTitle!]!.add(customer);
        } else {
          groupedCustomers[customer.queueNumTitle!] = [customer];
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            children: [
              Icon(Icons.restaurant_menu, size: 50),

              // store.maybeWhen(
              //   data: (storeData) {
              //     return StoreLogoPage();
              //   },
              //   orElse: () => Text(''),
              // )
            ],
          ),
        ),
      ),

      body: store.when(
        data: (data) {
          return _buildContent(
              context, groupedCustomers, categoryInfo.categories);
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          log('Error$error');
          return Center(child: Text('Error: '));
        },
      ),

      /// 設定按鈕
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          store.when(
            data: (storeData) {
              ///傳遞 顧客模式
              ref.read(adminPageProvider.notifier).setSelectedMode("顧客模式");
              // return showNumericPadDialog(context, AdminRoute(),
              //     storeId: storeData.storeId);
              AutoRouter.of(context).replace(AdminRoute());
            },
            loading: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
              );
            },
            error: (error, stackTrace) async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to load store data: $error'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
              AutoRouter.of(context).replace(AdminRoute());
            },
          );
        },
        child: Icon(Icons.settings, color: Colors.black54),
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildContent(BuildContext context,
      Map<String, List<Customer>> groupedCustomers, List<Category> categories) {
    return ResponsiveVisibility(
      visible: false,
      visibleConditions: [Condition.largerThan(name: MOBILE)],
      replacement: Container(), // 這裡是手機佈局，可以先留空
      child: TabletLayout(
          groupedCustomers: groupedCustomers,
          categories:
              categories.where((category) => category.hideQueue).toList()),
    );
  }
}

class TabletLayout extends ConsumerStatefulWidget {
  final Map<String, List<Customer>> groupedCustomers;
  final List<Category> categories;

  TabletLayout({
    required this.categories,
    required this.groupedCustomers,
  });

  ConsumerState<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends ConsumerState<TabletLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationHelper = NavigationHelper(ref, context);
    final store = ref.watch(storeProvider);
    final checkLastStatus = store.maybeWhen(
      data: (storeData) {
        return storeData.extendedMode == "Y";
      },
      orElse: () => false,
    );

    final Store? storedata = store.maybeWhen(
      data: (storeData) {
        return storeData;
      },
      orElse: () => null,
    );
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Text("${storedata?.storeName ?? ""}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: AppColors.primaryColor))),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 11,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                '目前已叫號的顧客',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: GridView.builder(
                              // shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveValue<int>(
                                  context,
                                  defaultValue: 2,
                                  conditionalValues: [
                                    Condition.largerThan(
                                        name: TABLET,
                                        value: widget.categories.length == 1 ||
                                                widget.categories.length == 2
                                            ? 1
                                            : 2),
                                    Condition.largerThan(
                                        name: DESKTOP, value: 4),
                                  ],
                                ).value!,
                                childAspectRatio:
                                    // 1,
                                    ResponsiveValue<double>(
                                  context,
                                  defaultValue: 3,
                                  conditionalValues: [
                                    Condition.largerThan(
                                        name: TABLET,
                                        value: checkHeightValue(
                                            widget.categories.length, 3)),
                                    Condition.largerThan(
                                        name: DESKTOP, value: 3),
                                  ],
                                ).value!,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: widget.categories.length,
                              itemBuilder: (context, index) {
                                final category = widget.categories[index];
                                final customerList = widget
                                    .groupedCustomers[category.queueNumTitle];
                                final customer = customerList != null &&
                                        customerList.isNotEmpty
                                    ? customerList.lastWhere(
                                        (customer) => checkLastStatus
                                            ? customer.queueStatus ==
                                                'processing'
                                            : customer.queueStatus ==
                                                'finished',
                                        orElse: () => Customer(
                                          id: 0,
                                          number: "0",
                                          queueNum: "--",
                                          checkinType: "",
                                          storeId: "",
                                          time: "",
                                          checkTime: "",
                                          queueType: 0,
                                          numberOfPeople: 0,
                                          queueNumTitle: "",
                                          queueStatus: "done",
                                          queueTypeName: "",
                                          needs: "",
                                        ),
                                      )
                                    : Customer(
                                        id: 0,
                                        number: "0",
                                        queueNum: "--",
                                        checkinType: "",
                                        storeId: "",
                                        time: "",
                                        checkTime: "",
                                        queueType: 0,
                                        numberOfPeople: 0,
                                        queueNumTitle: "",
                                        queueStatus: "done",
                                        queueTypeName: "",
                                        needs: "",
                                      );

                                return Container(
                                  // width: double.infinity,
                                  // height: double.infinity,
                                  decoration: BoxDecoration(
                                      // color: Colors.amber,
                                      // border: Border.all(color: Colors.black),
                                      // borderRadius: BorderRadius.circular(8),
                                      ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        // padding: EdgeInsets.all(8.0),
                                        // margin: EdgeInsets.only(top: 10),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            // '${category.queueTypeName}',
                                            '${category.queuePeopleMin}-${category.queuePeopleMax} 人',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          // color: Colors.amber,
                                          child: FittedBox(
                                            fit: BoxFit.fitHeight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom:
                                                      10.0), // 添加內間距來確保文本不緊貼頂部
                                              child: Text(
                                                customer.queueNum,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.CommonText),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // Expanded(
                          //   flex: 1,
                          //   child: Container(),
                          // )
                        ],
                      ),
                    ),
                    SizedBox(width: 24),
                    store.maybeWhen(
                      data: (storeData) {
                        return Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.amber,
                                  child: buildWaitingInfo(
                                      context,
                                      widget.categories,
                                      widget.groupedCustomers,
                                      storeData.showGroupsOrPeople,
                                      storeData.allWaitingTimeDisplayed //
                                      ),
                                ),
                              ),
                              SizedBox(height: 32),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  height: ResponsiveValue<double>(context,
                                      defaultValue:
                                          MediaQuery.sizeOf(context).height *
                                              0.25,
                                      conditionalValues: [
                                        Condition.largerThan(
                                            name: TABLET,
                                            value: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.3),
                                        Condition.largerThan(
                                            name: DESKTOP,
                                            value: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.15),
                                      ]).value!,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (storeData.stopTakingNumbers == "N") {
                                        ref
                                            .read(currentCustomerProvider
                                                .notifier)
                                            .initialCustomer(isCustomer: true);
                                        navigationHelper.navigateToNextPage();
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildStopTakingButtonText(
                                            storeData.stopTakingNumbers ?? ""),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          storeData.stopTakingNumbers == "N"
                                              ? AppColors.primaryColor
                                              : Colors.grey,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              )
                            ],
                          ),
                        );
                      },
                      loading: () {
                        return Container();
                      },
                      orElse: () {
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildStopTakingButtonText(String stopTakingNumbers) {
    if (stopTakingNumbers == "N") {
      return Column(
        children: [
          Text(
            '請點擊這裡 ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.sp,
            ),
          ),
          Text(
            '開始候位',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
        ],
      );
    } else {
      return Text(
        '停止領取號碼',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }
}

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

List<Widget> buildGroupWaitingList(
    List<Category> categories, Map<String, List<Customer>> groupedCustomers,
    {bool isDialog = false}) {
  return categories.map((category) {
    final groupCustomers = groupedCustomers[category.queueNumTitle]
            ?.where((customer) => customer.queueStatus == 'waiting')
            .toList() ??
        [];
    final totalWaitingTime =
        calculateTotalWaitingTime(groupCustomers, category.waitingTime);
    if (isDialog) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${category.queueNumTitle}(${category.queueTypeName})',
                style: TextStyle(fontSize: 20, color: AppColors.White),
              ),
              Text(
                '${groupCustomers.length} 組',
                style: TextStyle(fontSize: 20, color: AppColors.White),
              ),
            ],
          ),
          buildWaitingTime(totalWaitingTime.toString(), isDialog)
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${category.queueNumTitle}(${category.queueTypeName})',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${groupCustomers.length} 組',
            style: TextStyle(fontSize: 20),
          ),
          buildWaitingTime(totalWaitingTime.toString(), isDialog)
        ],
      );
    }
  }).toList();
}

int calculateTotalWaitingTime(List<Customer> customers, int averageWaitTime) {
  if (customers.isEmpty) return 0;
  return customers.length * averageWaitTime;
}

List<Widget> buildPeopleWaitingList(
    List<Category> categories, Map<String, List<Customer>> groupedCustomers,
    {bool isDialog = false}) {
  return categories.map((category) {
    final peopleCount = groupedCustomers[category.queueNumTitle]
            ?.where((customer) => customer.queueStatus == 'waiting')
            .fold<int>(
                0,
                (sum, customer) =>
                    sum +
                    (customer.numberOfPeople ?? 0) +
                    (customer.numberOfChild ?? 0)) ??
        0;
    final groupCustomers = groupedCustomers[category.queueNumTitle]
            ?.where((customer) => customer.queueStatus == 'waiting')
            .toList() ??
        [];
    final totalWaitingTime =
        calculateTotalWaitingTime(groupCustomers, category.waitingTime);
    if (isDialog) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${category.queueNumTitle}(${category.queueTypeName})',
                style: TextStyle(fontSize: 20, color: AppColors.White),
              ),
              Text(
                '${peopleCount} 人',
                style: TextStyle(fontSize: 20, color: AppColors.White),
              ),
            ],
          ),
          buildWaitingTime(totalWaitingTime.toString(), isDialog)
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${category.queueNumTitle}(${category.queueTypeName})',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${peopleCount} 人',
            style: TextStyle(fontSize: 20),
          ),
          buildWaitingTime(totalWaitingTime.toString(), isDialog)
        ],
      );
    }
  }).toList();
}

Widget buildWaitingTime(String? time, bool isDialog) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '預估等待時間:',
        style: TextStyle(
            fontSize: 20, color: isDialog ? Colors.white : Colors.black),
      ),
      Text(
        '$time 分鐘',
        style: TextStyle(
            fontSize: 20, color: isDialog ? Colors.white : Colors.black),
      ),
    ],
  );
}

double checkHeightValue(int length, double value) {
  switch (length) {
    case 1:
      return 1.3;
    case 2:
      return 2.2;
    case 3:
      return 1.2;
    case 4:
      return 1.2;
    default:
      return 1.5;
  }
}

Widget buildWaitingInfo(
    BuildContext context,
    List<Category> categories,
    Map<String, List<Customer>> groupedCustomers,
    String? showGroupsOrPeople,
    String? allWaitingTimeDisplayed) {
  final (totalCount, displayedWaitingTime) = calculateWaitingInfo(categories,
      groupedCustomers, showGroupsOrPeople, allWaitingTimeDisplayed);
  final String unit = showGroupsOrPeople == "groups" ? "組" : "人";

  return Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildInfoColumn(
        title: '等待$unit數',
        value: totalCount,
        unit: unit,
        icon: Icons.groups_outlined,
      ),
      Expanded(
          flex: 1,
          // child: VerticalDivider(
          //   color: Colors.grey,
          //   thickness: 1,
          //   width: 1,
          // ),
          child: Center(
              child: DashedLine_vertical(
            color: Colors.grey,
            dotSize: 1,
            dotSpace: 1,
          ))),
      _buildInfoColumn(
        title: '預計等待時間',
        value: displayedWaitingTime,
        unit: '分鐘',
        icon: Icons.schedule,
        prefix: '約 ',
        useCircularBackground: true,
      ),
    ],
  );
}

Widget _buildInfoColumn({
  required String title,
  required int value,
  required String unit,
  required IconData icon,
  String? prefix,
  bool useCircularBackground = false,
}) {
  return Expanded(
    flex: 2,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  title,
                  style:
                      TextStyle(fontSize: 6.8.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                  child: useCircularBackground
                      ? IconBackground(
                          iconPath: "assets/images/icon/schedule.svg",
                          color: Colors.grey[300]!,
                          size: constraints.maxWidth * 0.5,
                        )
                      : Icon(
                          icon,
                          size: constraints.maxWidth * 0.5,
                          color: AppColors.CommonText,
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: _buildValueText(value, unit, prefix),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildValueText(int value, String unit, String? prefix) {
  if (value <= 0 && unit == '分鐘') {
    return Text(
      '無等待',
      style: TextStyle(
        fontSize: 6.8.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.CommonText,
      ),
      textAlign: TextAlign.center,
    );
  }

  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        if (prefix != null)
          TextSpan(
            text: prefix,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.CommonText,
            ),
          ),
        TextSpan(
          text: '$value',
          style: TextStyle(
            fontSize: 20.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.CommonText,
          ),
        ),
        TextSpan(
          text: ' $unit',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.CommonText,
          ),
        ),
      ],
    ),
  );
}

(int, int) calculateWaitingInfo(
    List<Category> categories,
    Map<String, List<Customer>> groupedCustomers,
    String? showGroupsOrPeople,
    String? allWaitingTimeDisplayed) {
  int totalCount = 0;
  int totalWaitingTime = 0;
  List<int> categoryWaitingTimes = [];
  List<int> categoryCounts = [];

  for (var category in categories) {
    final customers = groupedCustomers[category.queueNumTitle]
            ?.where((customer) => customer.queueStatus == 'waiting')
            .toList() ??
        [];

    int categoryCount = showGroupsOrPeople == "groups"
        ? customers.length
        : customers.fold<int>(
            0,
            (sum, customer) =>
                sum +
                (customer.numberOfPeople ?? 0) +
                (customer.numberOfChild ?? 0));

    totalCount += categoryCount;

    int categoryWaitingTime =
        calculateTotalWaitingTime(customers, category.waitingTime);
    totalWaitingTime += categoryWaitingTime;

    if (categoryWaitingTime > 0) {
      categoryWaitingTimes.add(categoryWaitingTime);
      categoryCounts.add(categoryCount);
    }
  }

  int displayedWaitingTime;
  int displayedCount;
  switch (allWaitingTimeDisplayed) {
    case 'earliest':
      if (categoryWaitingTimes.isEmpty) {
        displayedWaitingTime = 0;
        displayedCount = 0;
      } else {
        int minIndex =
            categoryWaitingTimes.indexOf(categoryWaitingTimes.reduce(math.min));
        displayedWaitingTime = categoryWaitingTimes[minIndex];
        displayedCount = categoryCounts[minIndex];
      }
      break;
    case 'last':
      if (categoryWaitingTimes.isEmpty) {
        displayedWaitingTime = 0;
        displayedCount = 0;
      } else {
        int maxIndex =
            categoryWaitingTimes.indexOf(categoryWaitingTimes.reduce(math.max));
        displayedWaitingTime = categoryWaitingTimes[maxIndex];
        displayedCount = categoryCounts[maxIndex];
      }
      break;
    case 'total':
    default:
      displayedWaitingTime = totalWaitingTime;
      displayedCount = totalCount;
  }

  return (displayedCount, displayedWaitingTime);
}

Widget buildWaitingInfoForDialog(
    BuildContext context,
    List<Category> categories,
    Map<String, List<Customer>> groupedCustomers,
    String? showGroupsOrPeople,
    String? allWaitingTimeDisplayed) {
  final (totalCount, displayedWaitingTime) = calculateWaitingInfo(categories,
      groupedCustomers, showGroupsOrPeople, allWaitingTimeDisplayed);
  final String unit = showGroupsOrPeople == "groups" ? "組" : "人";

  return Container(
    width: MediaQuery.of(context).size.width * 0.5,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    ),
    // padding: EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "等待${unit}數",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "$totalCount$unit",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ),
          ],
        ),
        // SizedBox(height: 20),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "等待時間",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "$displayedWaitingTime分鐘以上",
                  style: TextStyle(color: Colors.white, fontSize: 10.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
