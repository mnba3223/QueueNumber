import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';

/// final page for customer mode
/// success page
@RoutePage()
class FinalCheck extends ConsumerStatefulWidget {
  final Customer? customer;

  FinalCheck({super.key, this.customer});
  @override
  ConsumerState<FinalCheck> createState() => _FinalCheckState();
}

class _FinalCheckState extends ConsumerState<FinalCheck> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.read(currentCustomerProvider);
    final categories = ref.read(categoryProvider).categories;
    // 找到與客戶 queueType 相匹配的 category
    final matchedCategory = categories.firstWhere(
      (category) => category.queueType == customer?.queueType,
    );
    // 計算預計等待時間
    final queueInfo = ref.watch(customerQueueProvider);
    final categoryCustomers = queueInfo.customers.where((c) =>
        c.queueType == matchedCategory.queueType && c.queueStatus == 'waiting');
    final estimatedWaitTime =
        categoryCustomers.length * matchedCategory.waitingTime;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '已完成候位',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: AppColors.primaryColor),
        ),
        centerTitle: true,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(1.0),
        //   child: Container(color: Colors.grey, height: 1.0),
        // ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.close),
          //   onPressed: () {
          //     showErrorDialog(context);
          //   },
          // )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.network('',
                      //     width: 100, height: 100), // 示例QR码图片
                      Center(
                          child: Text('透過LINE\n您可以即時查看候位狀態，\n還可以透過LINE設定和取消通話。',
                              textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('您的號碼為',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColors.CommonText,
                                  fontSize: 13.sp)),
                      Text('${customer?.queueNum ?? ""}',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColors.CommonText,
                                  fontSize: 30.sp)),
                      SizedBox(height: 10.sp),
                      Text(
                        '預計等待時間為',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: AppColors.CommonText, fontSize: 10.sp),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 5.sp),
                      Text(
                        '${estimatedWaitTime} 分鐘',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppColors.CommonText,
                                  fontSize: 12.sp,
                                ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                // color: AppColors.primaryColor,
                ),
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                ref.read(customerPageProvider.notifier).resetPages();
                context.router.replace(Customer_multiple_category_page());

                //hard reset if needed
                // await context.router.pushAndPopUntil(
                //   const Customer_page1(),
                //   predicate: (_) => false,
                // );
              },
              child: Text(
                '關閉',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  textStyle: TextStyle(fontSize: 20),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.sp),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

/// error dialog
void showErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 10),
            Text('スタックにお声掛けください'),
          ],
        ),
        content: Text('プリンタが未接続です。\n受付は登録されますが、番号が発行されません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close the dialog
            child: Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              // OK button logic
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
