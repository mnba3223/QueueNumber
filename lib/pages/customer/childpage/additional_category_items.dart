import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/services/app_router.gr.dart';

import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';

@RoutePage(name: 'additional_category_items')
class additional_category_items extends ConsumerStatefulWidget {
  const additional_category_items({super.key});

  @override
  ConsumerState<additional_category_items> createState() =>
      _additional_category_itemsState();
}

class _additional_category_itemsState
    extends ConsumerState<additional_category_items> {
  int _selectedIndex = -1; // 初始没有选择

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryProvider.notifier).fetchCategoriesFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationHelper = NavigationHelper(ref, context);
    final customer = ref.read(currentCustomerProvider);
    final categories = ref.read(categoryProvider).categories;
    final store = ref.watch(storeProvider);
    bool adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );
    final filteredCategories = categories.where((category) {
      return _isWithinRange(customer, category, adultsAndChildren);
    }).toList();

    List<String> topTexts = filteredCategories
        .map((category) =>
            "${category.queueNumTitle}  ${category.queueTypeName} (${category.queuePeopleMin} - ${category.queuePeopleMax} 人)")
        .toList();
    List<String> bottomTexts = filteredCategories
        .map((category) => calculateWaitTime(category, ref))
        .toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: "請選擇座位",
        onBackPressed: navigationHelper.navigateToPreviousPage,
        onReturnPressed: () async {
          navigationHelper.navigatetoFirstPage();
          context.router.replace(Customer_multiple_category_page());
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = filteredCategories[index];
                  return _buildButton(
                      index, topTexts[index], bottomTexts[index]);
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedIndex != -1) {
                    ref.read(currentCustomerProvider.notifier).setCustomer(
                        customer!.copyWith(
                            queueType:
                                filteredCategories[_selectedIndex].queueType));
                    navigationHelper.navigateToNextPage();
                  }
                },
                child: Text(
                  "下一步",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors.White,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildButton(int index, String topText, String bottomText,
      {bool isDisabled = false}) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = isSelected ? -1 : index;
        });
      },
      child: Container(
        // height: MediaQuery.of(context).size.width * 0.2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange[100] : Colors.white,
          border: Border.all(
            width: isSelected ? 5 : 2,
            color: isSelected ? AppColors.primaryColor : AppColors.primaryColor,
          ),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          /// 多時間的UI判斷
          // mainAxisAlignment: bottomText.isEmpty
          //     ? MainAxisAlignment.center
          //     : MainAxisAlignment.spaceBetween,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(top: 16.0),
            // child:
            Text(
              topText,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.primaryColor30,
                  ),
              textAlign: TextAlign.center,
            ),
            // ),

            ///多時間的判斷，有需要反註解
            // if (bottomText.isNotEmpty)
            //   Padding(
            //     padding: EdgeInsets.only(bottom: 16.0),
            //     child: Text(
            //       bottomText,
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  bool _isWithinRange(
      Customer? customer, Category category, bool showAdultsAndChildren) {
    if (customer == null) return false;
    final numberOfPeople = customer.numberOfPeople ?? 0;
    final totalPeople = showAdultsAndChildren
        ? numberOfPeople + (customer.numberOfChild ?? 0)
        : numberOfPeople;
    return totalPeople >= category.queuePeopleMin &&
        (category.queuePeopleMax == 0 ||
            totalPeople <= category.queuePeopleMax) &&
        category.hideQueue;
  }

  String calculateWaitTime(Category category, WidgetRef ref) {
    final queueInfo = ref.watch(customerQueueProvider);
    final categoryCustomers = queueInfo.customers.where((customer) =>
        customer.queueType == category.queueType &&
        customer.queueStatus == 'waiting');
    return '約${categoryCustomers.length * 5}分';
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
