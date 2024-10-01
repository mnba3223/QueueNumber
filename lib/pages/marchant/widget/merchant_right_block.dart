import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/state/callingStatus.dart';
import 'package:qswait/pages/marchant/widget/UI.dart';
import 'package:qswait/pages/marchant/widget/customer_dialog_page.dart';
import 'package:qswait/pages/marchant/style/shop_style.dart';
import 'package:qswait/pages/marchant/widget/customer_edit_dialog.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';

class RightBlockPage extends ConsumerStatefulWidget {
  final CustomerPageNotifier customerPageNotifier;
  final CustomerQueueInfo queueInfo;
  final List<Category> categories;
  const RightBlockPage(
      this.customerPageNotifier, this.queueInfo, this.categories,
      {super.key});

  @override
  ConsumerState<RightBlockPage> createState() => _RightBlockPageState();
}

class _RightBlockPageState extends ConsumerState<RightBlockPage> {
  @override
  Widget build(BuildContext context) {
    final store = ref.watch(storeProvider);
    final bool calculateOnlyUncalled = store.maybeWhen(
      data: (data) => data.useNoCallToCalculate == 'N',
      orElse: () => true,
    ); // 根據開關來決定計算邏輯

    final waitingCustomers = widget.queueInfo.customers
        .where((customer) =>
            (customer.queueStatus == 'waiting') &&
            widget.categories.any((category) {
              if (calculateOnlyUncalled) {
                return category.queueType == customer.queueType &&
                    CallingStatusExtension.fromString(customer.callingStatus) ==
                        CallingStatus.notCalled;
              } else {
                return category.queueType == customer.queueType;
              }
            }))
        .toList();
    final callingCustomers = widget.queueInfo.customers
        .where((customer) =>
            CallingStatusExtension.fromString(customer.callingStatus) ==
                CallingStatus.calling &&
            widget.categories
                .any((category) => category.queueType == customer.queueType))
        .toList();

    ///計算組數
    final waitingCount = waitingCustomers.length;
    // final averageWaitTime = waitingCount * 5; // 等待时间每组按5分钟计算

// 計算平均等待時間，每組按各自的類別等待時間計算
    final totalWaitTime = waitingCustomers.fold<int>(0, (sum, customer) {
      final category = widget.categories.firstWhere(
        (category) => category.queueType == customer.queueType,
        // orElse: () => null,
      );
      return sum + (category?.waitingTime ?? 0);
    });

    ///計算人數
    final waitingPeopleCount = waitingCustomers.fold<int>(
        0,
        (sum, customer) =>
            sum +
            (customer.numberOfPeople ?? 0) +
            (customer.numberOfChild ?? 0));

    return Column(
      children: [
        // top
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: DottedBorder(
                  color: AppColors.dotLine,
                  customPath: (size) {
                    return Path()
                      ..moveTo(0, 0)
                      ..lineTo(0, size.height);
                  },
                  child: Container(
                    // margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: store.maybeWhen(
                      data: (storeData) {
                        return Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.people_alt,
                                          color:
                                              Color.fromRGBO(121, 118, 125, 1),
                                        ),
                                        Text(
                                            storeData.showGroupsOrPeople ==
                                                    "groups"
                                                ? " 現在等待組數"
                                                : " 現在等待人數",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   '約',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 20),
                                        // ),
                                        Baseline(
                                          baseline: 10,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            storeData.showGroupsOrPeople ==
                                                    "groups"
                                                ? ' $waitingCount '
                                                : ' $waitingPeopleCount ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                          ),
                                        ),
                                        Baseline(
                                          baseline: 0,
                                          baselineType: TextBaseline.alphabetic,
                                          child: ShopTextSetting
                                              .shop_table_calling_text_style(
                                            storeData.showGroupsOrPeople ==
                                                    "groups"
                                                ? "組"
                                                : "人",
                                            color: AppColors.CommonText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.people),
                            //   title: Text('現在等待組數'),
                            //   trailing: Text(
                            //     '$waitingCount 組',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold, fontSize: 30),
                            //   ),
                            // ),

                            DashedLine(
                              dotSize: 2,
                              dotSpace: 5,
                            ),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          color:
                                              Color.fromRGBO(121, 118, 125, 1),
                                        ),
                                        Text(
                                          " 現在等待時間",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Baseline(
                                          baseline: 0,
                                          baselineType: TextBaseline.alphabetic,
                                          child: ShopTextSetting
                                              .shop_table_calling_text_style(
                                            "約",
                                            color: AppColors.CommonText,
                                          ),
                                        ),
                                        Baseline(
                                          baseline: 10,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            ' $totalWaitTime ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                          ),
                                        ),
                                        Baseline(
                                          baseline: 0,
                                          baselineType: TextBaseline.alphabetic,
                                          child: ShopTextSetting
                                              .shop_table_calling_text_style(
                                            "分",
                                            color: AppColors.CommonText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Divider(),
                            // ListTile(
                            //   leading: Icon(Icons.timer),
                            //   title: Text('現在等待時間'),
                            //   trailing: Text(
                            //     '約 $averageWaitTime 分',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold, fontSize: 30),
                            //   ),
                            // ),
                            SizedBox(height: 30),
                            Container(
                              margin: EdgeInsets.only(bottom: 2.dg),
                              width: double.infinity,
                              // height: Medi aQuery.of(context).size.height * 0.08,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // await showAddCustomerDialog(context, ref);
                                  await showEditCustomerDialog(context, ref);
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(239, 140, 38, 1),
                                  padding: EdgeInsets.symmetric(vertical: 3.dg),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_add_alt_1,
                                      size: 8.dg,
                                      color: AppColors.White,
                                    ),
                                    Text(' 新增顧客',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () {},
                      error: (error, stack) {},
                      orElse: () {},
                    ),
                  ),
                ),
              ),
              // bottom block
              Expanded(
                  flex: 3,
                  child: Container(
                    color: AppColors.primaryBackgroundColor,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(color: Colors.grey[300]!),
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    // padding: const EdgeInsets.all(16.0),
                    child: CustomNumberCard_v2(
                      icon: Icons.filter_none,
                      title: '現在叫的號碼為',
                      numbers: callingCustomers
                          .map((customer) => customer.queueNum)
                          .toList(),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
