import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/state/callingStatus.dart';
import 'package:qswait/models/state/queueStatus.dart';
import 'package:qswait/pages/marchant/function/function.dart';
import 'package:qswait/pages/marchant/widget/slider_status.dart';
import 'package:qswait/pages/marchant/style/shop_style.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/time.dart';
import 'package:qswait/widgets/UI.dart';
import 'package:collection/collection.dart';

class LeftBlockPage2 extends ConsumerStatefulWidget {
  final WidgetRef passedRef;
  final String queueTypeFilter;
  final List<Category> categories;
  const LeftBlockPage2(this.passedRef, this.queueTypeFilter, this.categories,
      {super.key});
  @override
  ConsumerState<LeftBlockPage2> createState() => _LeftBlockPage2State();
}

class _LeftBlockPage2State extends ConsumerState<LeftBlockPage2> {
  List<Customer> _filteredRows = [];
  int? _expandedIndex;
  bool expandAll = false;
  QueueStatus selectedSegment = QueueStatus.Waiting;
  String selectedCallStatus = "AllStatus";

  @override
  void initState() {
    super.initState();
    filterRows(selectedSegment, widget.queueTypeFilter, selectedCallStatus);
  }

  void filterRows(
      QueueStatus status, String queueTypeFilter, String callStatus) {
    final queueInfo = widget.passedRef.watch(customerQueueProvider);
    setState(() {
      _filteredRows = queueInfo.customers.where((customer) {
        bool matchesStatus = customer.queueStatus == status.toShortString();
        bool matchesQueueType = queueTypeFilter == 'AllCategory' ||
            customer.queueTypeName == queueTypeFilter;
        // widget.categories.any((category) =>
        //     category.queueTypeName == queueTypeFilter &&
        //     category.queueNumTitle == customer.queueNumTitle);
        bool isCategoryVisble = widget.categories.any((category) =>
            category.queueTypeName == customer.queueTypeName &&
            category.hideQueue);
        bool matchesCallStatus =
            callStatus == "AllStatus" || callStatus == customer.callingStatus;
        return matchesStatus &&
            matchesQueueType &&
            matchesCallStatus &&
            isCategoryVisble;
      }).toList()
        ..sort((a, b) => a.currentSort!.compareTo(b.currentSort!));
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = widget.passedRef.watch(storeProvider);

    AsyncValue<bool> isExtendedMode =
        store.whenData((data) => data.extendedMode == 'Y');
    filterRows(selectedSegment, widget.queueTypeFilter, selectedCallStatus);
    AsyncValue<bool> showAdultsAndChildren =
        store.whenData((data) => data.adultsAndChildren == 'Y');

    AsyncValue<bool> showNumberOfPeople =
        store.whenData((data) => data.numberOfPeople == 'N');
    AsyncValue<Store> storeData = store.whenData((data) => data);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isExtendedMode.when(
            data: (extendedMode) => buildSegmentedButton(context, extendedMode),
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
          SizedBox(height: 16),
          // Divider(),
          Center(child: buildDropdownButton(context)),
          SizedBox(height: 8),
          buildTableHeader(storeData),
          Divider(),
          // Expanded(
          //     child: buildDataTable(showAdultsAndChildren, showNumberOfPeople)),
          Expanded(
            child: ListView(
              children: _filteredRows
                  .map((customer) => buildCustomerRow(
                        customer,
                        context,
                        showAdultsAndChildren,
                        showNumberOfPeople,
                        storeData,
                        widget.categories,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSegmentedButton(BuildContext context, bool extendedMode) {
    return SegmentedButton<QueueStatus>(
      segments: extendedMode
          ? [
              ButtonSegment(
                value: QueueStatus.Waiting,
                label: ShopTextSetting.shop_title_medium_text_style(
                  context.tr("waiting"),
                ),
              ),
              ButtonSegment(
                value: QueueStatus.Processing,
                label: ShopTextSetting.shop_title_medium_text_style(
                  context.tr("processing"),
                ),
              ),
              ButtonSegment(
                value: QueueStatus.Finished,
                label: ShopTextSetting.shop_title_medium_text_style(
                  context.tr("finished"),
                ),
              ),
              ButtonSegment(
                value: QueueStatus.Cancelled,
                label: ShopTextSetting.shop_title_medium_text_style(
                  context.tr("cancelled"),
                ),
              )
            ]
          : [
              ButtonSegment(
                  value: QueueStatus.Waiting,
                  label: ShopTextSetting.shop_title_medium_text_style(
                    context.tr("waiting"),
                  )),
              ButtonSegment(
                  value: QueueStatus.Finished,
                  label: ShopTextSetting.shop_title_medium_text_style(
                    context.tr("seating"),
                  )),
              ButtonSegment(
                  value: QueueStatus.Cancelled,
                  label: ShopTextSetting.shop_title_medium_text_style(
                    context.tr("cancelled"),
                  )),
            ],
      onSelectionChanged: (newSelection) {
        setState(() {
          selectedSegment = newSelection.first;
          filterRows(
              selectedSegment, widget.queueTypeFilter, selectedCallStatus);
        });
      },
      showSelectedIcon: false,
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          return TextStyle(
            fontSize: 24,
            color: AppColors.primaryColor,
          );
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.segmentedSlectedColor;
          }
          return AppColors.backgroundColor;
        }),
        side: MaterialStateProperty.resolveWith<BorderSide>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return BorderSide.none; // 选中时无边框
          }
          return BorderSide(color: AppColors.primaryColor, width: 1); // 默认边框颜色
        }),
        splashFactory: NoSplash.splashFactory,
      ),
      selected: {selectedSegment},
    );
  }

  Widget buildDropdownButton(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCallStatus,
      icon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryColor,
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedCallStatus = newValue!;
          filterRows(
              selectedSegment, widget.queueTypeFilter, selectedCallStatus);
        });
      },
      items: <String>['AllStatus']
          .followedBy(CallingStatus.values
              .where((status) => status != CallingStatus.callAgain)
              .map((status) => status.toShortString()))
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            callingStatusLocalized(context, value.toLowerCase()),
            // style: TextStyle(
            //     color: AppColors.primaryColor,
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      }).toList(),
      style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
      underline: Container(), // 去掉下划线
    );
  }

  // Widget buildTableHeader(AsyncValue<bool> showNumberOfPeople) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
  //     child: Row(
  //       children: [
  //         Expanded(
  //             child: Center(
  //                 child: Text('號碼',
  //                     // style: TextStyle(
  //                     //     fontSize: 20,
  //                     //     fontWeight: FontWeight.w500,
  //                     //     color: AppColors.ShopTitleText)
  //                     style: Theme.of(context).textTheme.bodyLarge))),
  //         Expanded(
  //             child: Center(
  //                 child: Text('預約時間',
  //                     style: Theme.of(context).textTheme.bodyLarge))),
  //         showNumberOfPeople.when(
  //           data: (show) => show
  //               ? Expanded(
  //                   child: Center(
  //                       child: Text('人數',
  //                           style: Theme.of(context).textTheme.bodyLarge)))
  //               : Container(),
  //           loading: () => Container(),
  //           error: (error, stack) => Container(),
  //         ),
  //         Expanded(
  //             child: Center(
  //                 child: Text('席位',
  //                     style: Theme.of(context).textTheme.bodyLarge))),
  //         Expanded(
  //             child: Center(
  //                 child: Text('狀態',
  //                     style: Theme.of(context).textTheme.bodyLarge))),
  //       ],
  //     ),
  //   );
  // }

  Widget buildTableHeader(AsyncValue<Store> store) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: Center(
                  child: Text('號碼',
                      // style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //     color: AppColors.ShopTitleText)
                      style: Theme.of(context).textTheme.bodyLarge))),
          Expanded(
              child: Center(
                  child: Text('預約時間',
                      style: Theme.of(context).textTheme.bodyLarge))),
          store.when(
            data: (storeData) => storeData.showWaitingTime == 'Y'
                ? Expanded(
                    child: Center(
                        child: Text('等候時間',
                            style: Theme.of(context).textTheme.bodyLarge)))
                : Container(),
            loading: () => Container(),
            error: (error, stack) => Container(),
          ),
          store.when(
            data: (storeData) => storeData.numberOfPeople == 'N'
                ? Expanded(
                    child: Center(
                        child: Text('人數',
                            style: Theme.of(context).textTheme.bodyLarge)))
                : Container(),
            loading: () => Container(),
            error: (error, stack) => Container(),
          ),
          Expanded(
              child: Center(
                  child: Text('席位',
                      style: Theme.of(context).textTheme.bodyLarge))),
          Expanded(
              child: Center(
                  child: Text('狀態',
                      style: Theme.of(context).textTheme.bodyLarge))),
        ],
      ),
    );
  }

  Widget buildCustomerRow(
      Customer customer,
      BuildContext context,
      AsyncValue<bool> showAdultsAndChildren,
      AsyncValue<bool> showNumberOfPeople,
      AsyncValue<Store> storeData,
      List<Category> categories) {
    // 找到對應的 category
    final category = categories.firstWhereOrNull(
      (category) =>
          category.queueType == customer.queueType && category.hideQueue,
    );

    return Column(
      key: ValueKey(customer.currentSort),
      children: [
        Slidable(
          endActionPane: ActionPane(
            extentRatio: getQueueStatusNumber(selectedSegment),
            motion: const ScrollMotion(),
            children: generateSlidableActions(
                selectedSegment, context, customer, widget.passedRef),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 16,
                ),
                child: Row(children: [
                  Expanded(
                      child: Center(
                          child: Text(customer.queueNum.toString(),
                              style:
                                  Theme.of(context).textTheme.displayLarge))),

                  Expanded(
                      child: Center(
                          child: ShopTextSetting.shop_table_text_style(
                              convertTimeTo24HourFormat(customer.time)))),
                  // child: Text(convertTimeTo24HourFormat(customer.time),
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyLarge
                  //         ?.copyWith(color: AppColors.neutral50)))),
                  storeData.when(
                    data: (storeData) => storeData.showWaitingTime == 'Y'
                        ? storeData.useNoCallToCalculate == 'N' &&
                                customer.callingStatus != "calling"
                            ? Expanded(
                                child: Center(
                                    child: Text(
                                        "${category?.waitingTime.toString() ?? 0}分鐘",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppColors.CommonText))))
                            : Expanded(child: Text(""))
                        : Container(),
                    loading: () => Container(),
                    error: (error, stack) => Container(),
                  ),
                  showNumberOfPeople.when(
                    data: (show) => show
                        ? showAdultsAndChildren.when(
                            data: (adultsAndChildren) => adultsAndChildren
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ShopTextSetting.shop_table_text_style(
                                            '大人 ${customer.numberOfPeople} 位'),
                                        // Text('大人 ${customer.numberOfPeople} 位',
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodyLarge
                                        //         ?.copyWith(
                                        //             color:
                                        //                 AppColors.neutral50)),
                                        ShopTextSetting.shop_table_text_style(
                                            '小孩 ${customer.numberOfChild} 位'),
                                        // Text('小孩 ${customer.numberOfChild} 位',
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodyLarge
                                        //         ?.copyWith(
                                        //             color:
                                        //                 AppColors.neutral50)),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Center(
                                        // child: Text(
                                        //     "${(customer.numberOfPeople ?? 0) + (customer.numberOfChild ?? 0)}人",
                                        //     style: TextStyle(fontSize: 18))),
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ShopTextSetting
                                            .shop_headerline_large_text_style(
                                                "${(customer.numberOfPeople ?? 0) + (customer.numberOfChild ?? 0)}"),
                                        ShopTextSetting.shop_table_text_style(
                                            "位"),
                                      ],
                                    )),
                                  ),
                            loading: () => Container(),
                            error: (error, stack) => Container(),
                          )
                        : Container(),
                    loading: () => Container(),
                    error: (error, stack) => Container(),
                  ),

                  Expanded(
                      child: Center(
                          // child: Text(
                          //     "${customer.queueTypeName} (${category.queuePeopleMin}-${category.queuePeopleMax}人)",
                          //     style: TextStyle(fontSize: 16)))),
                          child: Column(
                    children: [
                      customer.needs != "" &&
                              customer.needs != "null" &&
                              customer.needs != null
                          ? ShopTextSetting.shop_table_text_style(
                              "備註: ${customer.needs}")
                          : Container(),
                      ShopTextSetting.shop_table_text_style(
                          "${customer.queueTypeName} (${category?.queuePeopleMin ?? 0}-${category?.queuePeopleMax ?? 0}人)"),
                    ],
                  ))),
                  Expanded(
                      child: Center(
                          child: buildCallingStatus(
                    customer,
                    context,
                    storeData.value,
                  ))),
                ]),
              ),
              // Divider(
              //   height: 1,
              //   color: Colors.grey,
              // ),

              DashedLine(
                dotSize: 2,
                dotSpace: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
