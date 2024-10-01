import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';

///create mutiple Text style for customer confirm page
@RoutePage()
class CustomerConfirmPage extends ConsumerStatefulWidget {
  const CustomerConfirmPage({super.key});

  @override
  ConsumerState<CustomerConfirmPage> createState() =>
      _CustomerConfirmPageState();
}

class _CustomerConfirmPageState extends ConsumerState<CustomerConfirmPage> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(currentCustomerProvider);
    final categories = ref.watch(categoryProvider).categories;
    final navigationHelper = NavigationHelper(ref, context);

    final bool adultsAndChildren = ref.watch(storeProvider).maybeWhen(
          data: (store) => store.adultsAndChildren == 'Y',
          orElse: () => false,
        );
    final Category category = categories
        .where((category) => category.queueType == customer?.queueType)
        .first;
    // Example UI to show filtered categories
    return Scaffold(
      appBar: CustomAppBar(
        title: "確認候位資訊",
        onBackPressed: navigationHelper.navigateToPreviousPage,
        onReturnPressed: () async {
          navigationHelper.navigatetoFirstPage();
          context.router.replace(Customer_multiple_category_page());
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    if (adultsAndChildren) ...[
                      buildInfoRow('大人:', '${customer?.numberOfPeople ?? 0} 名'),
                      buildInfoRow('小孩:', '${customer?.numberOfChild ?? 0} 名'),
                    ] else ...[
                      buildInfoRow('人數:',
                          '${(customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0)} 名'),
                    ],
                    buildInfoRow('座位:', '${category?.queueTypeName ?? '未知'}'),
                    buildInfoRow('備註:', '${customer?.needs ?? ''}'),
                  ],
                ),
              ),
              Container(
                // width: MediaQuery.of(context).size.width * 0.2,
                margin: EdgeInsets.only(
                  bottom: 16.0,
                ), // Add some margin at the bottom

                child: ElevatedButton(
                  onPressed: () {
                    navigationHelper.navigateToNextPage();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    child: Text(
                      "確認候位內容完成候位",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: AppColors.White,
                          ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyle(fontSize: 8.sp, color: AppColors.neutral60),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content,
                style: TextStyle(fontSize: 8.sp, color: AppColors.CommonText),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackPressed;
  final Function onReturnPressed;

  CustomAppBar(
      {required this.title,
      required this.onBackPressed,
      required this.onReturnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).appBarTheme.color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.primaryColor,
                      onPressed: () => onBackPressed(),
                    ),
                    Text(
                      "取消",
                      style: TextStyle(
                          fontSize: 6.8.sp, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    Text(
                      "取消申請",
                      style: TextStyle(
                          fontSize: 6.8.sp, color: AppColors.primaryColor),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      color: AppColors.primaryColor,
                      onPressed: () => onReturnPressed(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
