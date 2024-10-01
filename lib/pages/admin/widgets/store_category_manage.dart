import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/pages/admin/widgets/store_edit_page.dart';
import 'package:qswait/services/api/merchant.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';

class StoreCategoryManage extends ConsumerWidget {
  Future<void> _submitCategoryChange(BuildContext context, WidgetRef ref,
      Category category, String action) async {
    final response = await updateCategoryAPI(category, action);
    if (response.success) {
      await ref.read(categoryProvider.notifier).fetchCategoriesFromApi();
      if (!(action == "delete")) Navigator.of(context).pop();
    } else {
      log(response.message);
      if (response.message
          .contains('Invalid action value or queue type have waiting')) {
        showErrorDialog(context, 'Error', '尚有資料在排隊中，所以無法編輯與刪除');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to $action category: ${response.message}'),
          ),
        );
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Category category) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('確認刪除分類'),
        content: Text('您確定要刪除此分類嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('確認'),
          ),
        ],
      ),
    );

    if (result == true) {
      await _submitCategoryChange(context, ref, category, 'delete');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider).categories;

    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {
          Navigator.of(context).pop();
        },
        title: "編輯分類項目",
        onReturnPressed: () {},
      ),
      body: Container(
        color: AppColors.neutral94,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.remove_circle,
                            color: AppColors.removeColor),
                        onPressed: () => _confirmDelete(context, ref, category),
                      ),
                      title: Text(
                          '${category.queueTypeName} (${category.queuePeopleMin}-${category.queuePeopleMax}人)'),
                      subtitle: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('等待時間: ${category.waitingTime}分'),
                              SizedBox(
                                width: 16.sp,
                              ),
                              Text('代號: ${category.queueNumTitle}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StoreEditPage(
                              category: category,
                              onSubmit: (updatedCategory) =>
                                  _submitCategoryChange(
                                      context, ref, updatedCategory, 'update'),
                            ),
                          ));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            // if (categories.length < 4)
            //   SizedBox(
            //     height: 16,
            //   ),
            if (categories.length < 4 && categories.length >= 1)
              RoundedContainer(
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.add_circle,
                          size: 6.8.sp, color: AppColors.addCircle),
                      label: Text('新增分類',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColors.primaryColor)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoreEditPage(
                            onSubmit: (newCategory) => _submitCategoryChange(
                                context, ref, newCategory, 'create'),
                          ),
                        ));
                      },
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
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
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1.5.sp),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      color: AppColors.primaryColor,
                      onPressed: () => onBackPressed(),
                      iconSize: 8.sp,
                    ),
                    Text(
                      "離開",
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
                      .titleLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   child: Row(
              //     children: [
              //       Text(
              //         "save",
              //         style: TextStyle(
              //             fontSize: 6.8.sp, color: AppColors.primaryColor),
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.close),
              //         color: AppColors.primaryColor,
              //         onPressed: () => onReturnPressed(),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class RoundedContainer extends StatelessWidget {
  final Widget child;
  const RoundedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}
