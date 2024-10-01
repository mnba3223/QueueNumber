import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';

@RoutePage()
class spcialNote extends ConsumerStatefulWidget {
  const spcialNote({super.key});

  @override
  ConsumerState<spcialNote> createState() => _spcialNoteState();
}

class _spcialNoteState extends ConsumerState<spcialNote> {
  final TextEditingController _noteController = TextEditingController();
  // final store = ref.watch(storeProvider);
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(currentCustomerProvider);
    final navigationHelper = NavigationHelper(ref, context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "請選擇座位",
        onBackPressed: navigationHelper.navigateToPreviousPage,
        onReturnPressed: () async {
          navigationHelper.navigatetoFirstPage();
          context.router.replace(Customer_multiple_category_page());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              maxLength: 50,
              controller: _noteController,
              decoration: InputDecoration(
                hintText: '這裡輸入任何需求',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // ElevatedButton(
                //   onPressed: () {
                //     // 上一步逻辑
                //   },
                //   child: Text("上一步"),
                //   style: ElevatedButton.styleFrom(
                //     textStyle: TextStyle(fontSize: 20),
                //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      ///添加 客戶備注
                      ref.read(currentCustomerProvider.notifier).setCustomer(
                            customer!.copyWith(needs: _noteController.text),
                          );

                      // AutoRouter.of(context).push(FinalCheck());
                      navigationHelper.navigateToNextPage();
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
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// @RoutePage()
// class NotePadPage extends ConsumerStatefulWidget {
//   const NotePadPage({super.key});

//   @override
//   ConsumerState<NotePadPage> createState() => _NotePadPageState();
// }

// class _NotePadPageState extends ConsumerState<NotePadPage> {
//   @override
//   Widget build(BuildContext context) {
//     final customer = ref.watch(currentCustomerProvider);
//     final navigationHelper = NavigationHelper(ref, context);
//     final store = ref.watch(storeProvider);
//     // AsyncValue<bool> showNotePage =
//     return Container();
//   }
// }
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
