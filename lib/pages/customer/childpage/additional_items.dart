import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';

@RoutePage(name: 'additional_items')
class additional_items extends ConsumerStatefulWidget {
  const additional_items({super.key});

  @override
  ConsumerState<additional_items> createState() => _additional_itemsState();
}

class _additional_itemsState extends ConsumerState<additional_items> {
  int _selectedIndex = -1; // 初始没有选择
  @override
  Widget build(BuildContext context) {
    final navigationHelper = NavigationHelper(ref, context);
    final customer = ref.watch(currentCustomerProvider);
    // final apiService = ref.watch(apiServiceProvider);
    // final customer = ref.watch(currentCustomerProvider);
    // final customerPageNotifier = ref.read(customerPageProvider.notifier);
    // Future<void> navigateToNextPage() async {
    //   if (customerPageNotifier.hasNextPage()) {
    //     customerPageNotifier.toNextPage();
    //     context.router.pushNamed(customerPageNotifier.getCurrentPage());
    //   } else {
    //     // if list is complete, navigate to final check
    //     await addCustomer(apiService, customer!);
    //     context.router.push(FinalCheck());
    //   }
    // }

    return Scaffold(
        appBar: CustomAppBar(
          title: "請選擇座位",
          onBackPressed: navigationHelper.navigateToPreviousPage,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 三个元素一行
                          childAspectRatio: 2, // 宽高比为1:0.7
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 20),
                      itemCount: 3, // 只有三个按钮
                      itemBuilder: (BuildContext context, int index) {
                        return _buildButton(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2, // 按钮宽度填充整个屏幕宽
                  child: ElevatedButton(
                    onPressed: () async {
                      /// add selected item index to customer

                      ref.read(currentCustomerProvider.notifier).setCustomer(
                          customer!.copyWith(queueType: _selectedIndex));
                      print(customer);

                      /// navigate to next page
                      navigationHelper.navigateToNextPage();
                      // AutoRouter.of(context).push(SpcialNote());
                    },
                    child: Text("下一步"),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.2, // 按钮宽度填充整个屏幕宽
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("上一步"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20),
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildButton(int index) {
    List<String> topTexts = ["不指定", "一起", "可以單獨"];
    List<String> bottomTexts = ["", "約20分", ""];
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = _selectedIndex == index ? -1 : index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Colors.lightBlue[200]
              : Colors.grey[300],
          border: Border.all(
              width: 0.5, color: const Color.fromARGB(255, 207, 202, 202)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                topTexts[index],
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text(
                bottomTexts[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackPressed;

  CustomAppBar({required this.title, required this.onBackPressed});

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
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: AppColors.primaryColor,
                  onPressed: () => onBackPressed(),
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
