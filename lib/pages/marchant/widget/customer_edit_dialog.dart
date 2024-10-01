import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/state/callingStatus.dart';
import 'package:qswait/pages/marchant/widget/UI.dart';

import 'package:qswait/services/api/customers_api.dart';
import 'package:qswait/services/app_router.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';
import 'package:qswait/widgets/UI.dart';
import 'package:qswait/widgets/dialog.dart';
import 'package:qswait/widgets/num_pad/numeric_pad.dart';

Future<void> showEditCustomerDialog(BuildContext context, WidgetRef ref,
    {Customer? customer}) async {
  if (customer != null) {
    ref.read(currentCustomerProvider.notifier).setCustomer(customer);
  } else {
    ref.watch(currentCustomerProvider.notifier).initialCustomer();
  }
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return EditCustomerDialog(fatherRef: ref, isEdit: customer != null);
    },
  );
  ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
}

class EditCustomerDialog extends ConsumerStatefulWidget {
  final WidgetRef fatherRef;
  final bool isEdit;

  const EditCustomerDialog(
      {Key? key, required this.fatherRef, required this.isEdit})
      : super(key: key);

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends ConsumerState<EditCustomerDialog> {
  int _selectedMenuIndex = 0;
  int _selectedIndex = -1;
  List<String> seatOptions = [];
  bool _isDisposed = false;
  CancelToken? _cancelToken;

  TextEditingController _needsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        widget.fatherRef
            .read(categoryProvider.notifier)
            .fetchCategoriesFromApi(cancelToken: _cancelToken);
      }

      final category = ref.read(categoryProvider).categories;
      ref.read(currentCustomerProvider.notifier).setCustomer(
            ref.read(currentCustomerProvider)!.copyWith(
                queueType: 0, queueTypeName: category[0].queueTypeName),
          );
    });

    final customer = ref.read(currentCustomerProvider);
    if (customer != null) {
      _needsController.text = customer.needs ?? '';
    }
    _needsController.addListener(() {
      ref.read(currentCustomerProvider.notifier).setCustomer(
            ref.read(currentCustomerProvider)!.copyWith(
                  needs: _needsController.text,
                ),
          );
    });
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    _isDisposed = true;
    _needsController.dispose();
    super.dispose();
  }

  List<String> get menuOptions {
    final customer = ref.watch(currentCustomerProvider);
    final store = ref.watch(storeProvider);
    final adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );
    final options = adultsAndChildren
        ? [
            '大人: ${customer?.numberOfPeople ?? 0} 名',
            '小孩: ${customer?.numberOfChild ?? 0} 名',
            '座位選擇: ${seatOptions[customer?.queueType ?? 0]}',
          ]
        : [
            '人數: ${(customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0)} 名',
            '座位選擇: ${seatOptions[customer?.queueType ?? 0]}',
          ];
    final storeData = ref.watch(storeProvider).value;
    if (storeData?.useNotepad == 'Y') {
      options.add('備註');
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final queueInfo = widget.fatherRef.watch(customerQueueProvider);
    final customer = widget.fatherRef.watch(currentCustomerProvider);
    final categories =
        widget.fatherRef.watch(categoryProvider).categories.where((category) {
      return category.hideQueue;
    }).toList();

    final store = widget.fatherRef.watch(storeProvider);
    final bool calculateOnlyUncalled = store.maybeWhen(
      data: (data) => data.useNoCallToCalculate == 'N',
      orElse: () => true,
    ); // 根據開關來決定計算邏輯

    final waitingCustomers = queueInfo.customers
        .where((customer) =>
            (customer.queueStatus == 'waiting') &&
            categories.any((category) {
              if (calculateOnlyUncalled) {
                return category.queueType == customer.queueType &&
                    CallingStatusExtension.fromString(customer.callingStatus) ==
                        CallingStatus.notCalled;
              } else {
                return category.queueType == customer.queueType;
              }
            }))
        .toList();

    ///計算人數
    final waitingPeopleCount = waitingCustomers.fold<int>(
        0,
        (sum, customer) =>
            sum +
            (customer.numberOfPeople ?? 0) +
            (customer.numberOfChild ?? 0));
    // 計算平均等待時間，每組按各自的類別等待時間計算
    final totalWaitTime = waitingCustomers.fold<int>(0, (sum, customer) {
      final category = categories.firstWhere(
        (category) => category.queueType == customer.queueType,
        // orElse: () => null,
      );
      return sum + (category?.waitingTime ?? 0);
    });

    ///大人小孩開關
    final adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );

    ///跳過確認框開關 注意是關掉開關才是跳過
    final skipConfirmationScreen = store.maybeWhen(
      data: (data) => data.skipConfirmationScreen == 'N',
      orElse: () => false,
    );
    final String unit = store.value?.showGroupsOrPeople == "groups" ? "組" : "人";
    seatOptions = categories.map((category) => category.queueTypeName).toList();

    List<int> enabledIndices = [];
    for (int i = 0; i < categories.length; i++) {
      if (_isWithinRange(customer, categories[i], adultsAndChildren)) {
        enabledIndices.add(i);
      }
    }

    if (enabledIndices.length == 1 && _selectedIndex == -1) {
      _selectedIndex = enabledIndices.first;
      Future.microtask(() {
        ref.read(currentCustomerProvider.notifier).setCustomer(customer!
            .copyWith(
                queueType: _selectedIndex,
                queueTypeName: categories[_selectedIndex].queueTypeName));
        setState(() {});
      });
    } else if (_selectedIndex == -1 && enabledIndices.isNotEmpty) {
      _selectedIndex = enabledIndices.first;
      Future.microtask(() {
        ref.read(currentCustomerProvider.notifier).setCustomer(customer!
            .copyWith(
                queueType: _selectedIndex,
                queueTypeName: categories[_selectedIndex].queueTypeName));
        setState(() {});
      });
    }

    return AlertDialog(
      surfaceTintColor: AppColors.White,
      title: Container(
        padding: EdgeInsets.only(top: 5.sp),
        child: Container(
          // margin: EdgeInsets.all(1.5.sp),
          child: IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    widget.isEdit ? '編輯客户' : '新增客户',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.CommonText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: _buildContent(categories, adultsAndChildren),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.sp),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoColumn(
                          title: '等待$unit數',
                          value: store.value?.showGroupsOrPeople == "groups"
                              ? waitingCustomers.length
                              : waitingPeopleCount,
                          unit: unit,
                          icon: Icons.people_alt,
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
                          value: totalWaitTime,
                          unit: '分鐘',
                          icon: Icons.timelapse,
                          prefix: '約 ',
                          useCircularBackground: true,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10.sp),
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     '現在等待$unit數 ${waitingCustomers.length} 組',
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  //   ),
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     '現在等待時間 約 ${totalWaitTime} 分',
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  //   ),
                  // ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: menuOptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(menuOptions[index]),
                          selected: _selectedMenuIndex == index,
                          onTap: () {
                            setState(() {
                              _selectedMenuIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.sp, horizontal: 8.sp),
                child: Text(
                  '取消',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  side: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
            SizedBox(width: 10.sp), // 间隔
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(
                    adultsAndChildren, skipConfirmationScreen);
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.sp, horizontal: 8.sp),
                child: Text(
                  '確認',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.White),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // 背景颜色
                // onPrimary: Colors.white, // 文字颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.sp),
      ],
    );
  }

  Widget _buildContent(List<Category> categories, bool adultsAndChildren) {
    if (_selectedMenuIndex == 0 ||
        (adultsAndChildren && _selectedMenuIndex == 1)) {
      // return _buildNumpad(adultsAndChildren);
      return NumericPad3(
        onNumberPress: (number) =>
            _updateNumber(number, true, adultsAndChildren),
        onClearLast: () => _updateNumber('', false, adultsAndChildren),
      );
    } else if (_selectedMenuIndex == menuOptions.length - 1 &&
        ref.watch(storeProvider).value?.useNotepad == 'Y') {
      return TextField(
        controller: _needsController,
        decoration: InputDecoration(
          labelText: '備註',
          counterText: '${_needsController.text.length}/50',
        ),
        maxLength: 50,
      );
    } else {
      return _buildSeatSelection(categories);
    }
  }

  // Widget _buildNumpad(bool adultsAndChildren) {
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     shrinkWrap: true,
  //     children: [
  //       ...List.generate(9, (index) => index + 1).map((number) {
  //         return ElevatedButton(
  //           onPressed: () {
  //             _updateNumber('$number', adultsAndChildren);
  //           },
  //           style: ElevatedButton.styleFrom(
  //             shape: CircleBorder(),
  //             side: BorderSide(color: Colors.black),
  //           ),
  //           child: Text('$number', style: TextStyle(fontSize: 24)),
  //         );
  //       }).toList(),
  //       ElevatedButton(
  //         onPressed: () => _updateNumber('0', adultsAndChildren),
  //         style: ElevatedButton.styleFrom(
  //           shape: CircleBorder(),
  //           side: BorderSide(color: Colors.black),
  //         ),
  //         child: Text('0', style: TextStyle(fontSize: 24)),
  //       ),
  //       ElevatedButton(
  //         onPressed: () => _clearLastNumber(adultsAndChildren),
  //         style: ElevatedButton.styleFrom(
  //           shape: CircleBorder(),
  //           side: BorderSide(color: Colors.red),
  //         ),
  //         child: Text('清除', style: TextStyle(fontSize: 24, color: Colors.red)),
  //       ),
  //     ],
  //   );
  // }

  void _updateNumber(String number, bool isAdd, bool adultsAndChildren) {
    _updateCustomerNumber(
      number: number,
      isAdd: isAdd,
      adultsAndChildren: adultsAndChildren,
    );
  }

  Widget _buildSeatSelection(List<Category> categories) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.map((category) {
        final index = categories.indexOf(category);
        return ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedIndex = index;
              ref.read(currentCustomerProvider.notifier).setCustomer(ref
                  .read(currentCustomerProvider)!
                  .copyWith(
                      queueType: index, queueTypeName: category.queueTypeName));
            });
          },
          child: Text(category.queueTypeName),
        );
      }).toList(),
    );
  }

  void _updateCustomerNumber({
    required String number,
    required bool isAdd,
    required bool adultsAndChildren,
  }) {
    final customer = ref.read(currentCustomerProvider);
    String numberString = (adultsAndChildren && _selectedMenuIndex == 1)
        ? customer?.numberOfChild.toString() ?? "0"
        : adultsAndChildren
            ? (customer?.numberOfPeople ?? 0).toString()
            : ((customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0))
                .toString();

    if (isAdd) {
      if (numberString == "0") {
        numberString = number;
      } else if (numberString.length < 3) {
        numberString += number;
      }
    } else {
      if (numberString.length > 1) {
        numberString = numberString.substring(0, numberString.length - 1);
      } else {
        numberString = "0";
      }
    }

    final updatedCustomer = customer!.copyWith(
      numberOfPeople: (_selectedMenuIndex == 0)
          ? int.parse(numberString)
          : adultsAndChildren
              ? (customer.numberOfPeople)
              : int.parse(numberString),
      numberOfChild: (adultsAndChildren && _selectedMenuIndex == 1)
          ? int.parse(numberString)
          : adultsAndChildren
              ? customer.numberOfChild
              : 0,
      needs: _needsController.text,
    );
    ref.read(currentCustomerProvider.notifier).setCustomer(updatedCustomer);
    final categories = ref.read(categoryProvider).categories;
    List<int> enabledIndices = [];
    for (int i = 0; i < categories.length; i++) {
      if (_isWithinRange(updatedCustomer, categories[i], adultsAndChildren)) {
        enabledIndices.add(i);
      }
    }

    if (enabledIndices.length == 1) {
      _selectedIndex = enabledIndices.first;
      ref.read(currentCustomerProvider.notifier).setCustomer(
          updatedCustomer.copyWith(
              queueType: _selectedIndex,
              queueTypeName: categories[_selectedIndex].queueTypeName));
    } else if (enabledIndices.isNotEmpty) {
      _selectedIndex = enabledIndices.first;
      ref.read(currentCustomerProvider.notifier).setCustomer(
          updatedCustomer.copyWith(
              queueType: _selectedIndex,
              queueTypeName: categories[_selectedIndex].queueTypeName));
    }

    setState(() {});
  }

  void _showConfirmationDialog(
      bool adultsAndChildren, bool skipConfirmationScreen) async {
    final customer = ref.read(currentCustomerProvider);
    log("skipConfirmationScreen: $skipConfirmationScreen");
    if (!skipConfirmationScreen) {
      await _handleApiCall(skipConfirmationScreen);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認${widget.isEdit ? '編輯' : '新增'}客戶'),
          content: Text(adultsAndChildren
              ? '大人: ${customer?.numberOfPeople ?? 0} 名\n小孩: ${customer?.numberOfChild ?? 0} 名\n座位: ${customer?.queueTypeName ?? '未知'}\n備註: ${_needsController.text}'
              : '人數: ${(customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0)} 名\n座位: ${customer?.queueTypeName ?? '未知'}\n備註: ${_needsController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _handleApiCall(skipConfirmationScreen);
              },
              child: Text('確認'),
            ),
          ],
        );
      },
    );
  }

// 將API調用邏輯提取到單獨的方法中
  Future<void> _handleApiCall(bool skipConfirmationScreen) async {
    final navigationHelper = NavigationHelper(ref, context);
    final customer = ref.read(currentCustomerProvider);

    BuildContext currentStatecontext =
        getIt<AppRouter>().navigatorKey.currentState!.context;
    // 顯示加載對話框
    showDialog(
      context: currentStatecontext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // 調用 API
    final response = widget.isEdit
        ? await updateCustomerInfo(customer!)
        : await addCustomer(customer!);

    // 隱藏加載對話框

    Navigator.pop(currentStatecontext);

    if (response.success) {
      Navigator.pop(currentStatecontext);
      if (skipConfirmationScreen) {
        Navigator.pop(context);
      }
      // Navigator.pop(currentStatecontext);
    } else {
      navigationHelper.showErrorDialog(context, response.message);
    }
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
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Color.fromRGBO(121, 118, 125, 1),
                  ),
                  Text(
                    "$title",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            // Expanded(
            //   flex: 3,
            //   child: AspectRatio(
            //     aspectRatio: 1,
            //     child: FittedBox(
            //       child: useCircularBackground
            //           ? IconBackground(
            //               iconPath: "assets/images/icon/schedule.svg",
            //               color: Colors.grey[300]!,
            //               size: constraints.maxWidth * 0.5,
            //             )
            //           : Icon(
            //               icon,
            //               size: constraints.maxWidth * 0.5,
            //               color: AppColors.CommonText,
            //             ),
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 1,
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
              fontSize: 7.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.CommonText,
            ),
          ),
        TextSpan(
          text: '$value',
          style: TextStyle(
            fontSize: 18.sp,
            // fontWeight: FontWeight.bold,
            color: AppColors.CommonText,
          ),
        ),
        TextSpan(
          text: ' $unit',
          style: TextStyle(
            fontSize: 7.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.CommonText,
          ),
        ),
      ],
    ),
  );
}
