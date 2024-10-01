import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/pages/admin/style/textstyle.dart';
import 'package:qswait/pages/admin/widgets/store_category_manage.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';

@RoutePage()
class WaitingItemTimeSettingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);
    final categories = ref.watch(categoryProvider).categories;
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.neutral94,
        child: store.when(
            data: (store) => SingleChildScrollView(
                  child: Column(
                    children: [
                      adminPageTitle("等待項目/等待時間"),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            _buildSectionTitle('等待時間'),
                            RoundedContainer(
                              child: Column(
                                children: [
                                  SwitchListTile(
                                    title: AdminTextSetting.adminTextStyle(
                                        '顯示每組客戶等待時間'),
                                    value: store.showWaitingTime == 'Y',
                                    onChanged: (value) {
                                      ref
                                          .read(storeProvider.notifier)
                                          .updateModeSwitch(
                                              AdminModeAction.showWaitingTime,
                                              value ? "Y" : "N");
                                    },
                                  ),
                                  SwitchListTile(
                                    title: AdminTextSetting.adminTextStyle(
                                        '僅計算未呼叫的接待人數和時間'),
                                    value: store.useNoCallToCalculate == 'N',
                                    onChanged: (value) {
                                      ref
                                          .read(storeProvider.notifier)
                                          .updateModeSwitch(
                                              AdminModeAction
                                                  .useNoCallToCalculate,
                                              value ? "N" : "Y");
                                    },
                                  ),
                                  ListTile(
                                    title: AdminTextSetting.adminTextStyle(
                                        '等待時間顯示方式'),
                                    subtitle: AdminTextSetting.adminTextStyle(
                                        "變更接待畫面上顯示的等待時間",
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.fontSize,
                                        color: AppColors.neutral50),
                                    trailing: AdminTextSetting.adminTextStyle(
                                        "最早呼叫的等待項目時間"),
                                    onTap: () {
                                      AutoRouter.of(context)
                                          .push(WaitingTimeDisplay());
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            _buildSectionTitle('等待項目'),
                            SizedBox(height: 10),
                            RoundedContainer(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 7.0.sp),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child:
                                              AdminTextSetting.adminTextStyle(
                                                  '標題'),
                                        ),
                                        Expanded(
                                          flex: 9,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: AdminTextSetting
                                                    .adminTextStyle(
                                                  '席位',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.all(3.sp),
                                    child: Divider(
                                      thickness: 2,
                                      color: AppColors.neutral80,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.sp, left: 7.sp),
                                          child: Text('項目'),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          // color: Colors.amber,
                                          child: Column(
                                            children:
                                                categories.map((category) {
                                              return _buildEditableWaitingItem(
                                                  context,
                                                  ref,
                                                  category,
                                                  store);
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    title: Center(
                                      child: AdminTextSetting.adminTextStyle(
                                          '點擊編輯項目',
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StoreCategoryManage()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, st) {
              log("$e");
              return Center(child: Text('加載資料錯誤: '));
            }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.grey, fontSize: 18),
    );
  }

  Widget _buildEditableWaitingItem(
      BuildContext context, WidgetRef ref, Category category, Store store) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${category.queueTypeName} (${category.queuePeopleMin}-${category.queuePeopleMax}人)',
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '等待時間: ${category.waitingTime} 分',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Switch(
                value: category.hideQueue,
                onChanged: (value) {
                  final visibleCategories = ref
                      .read(categoryProvider)
                      .categories
                      .where((cat) => cat.hideQueue)
                      .toList();
                  if (!value && visibleCategories.length <= 1) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('提示'),
                        content: Text('請至少保留一個分類'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('確定'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  ref.read(categoryProvider.notifier).updateCategoryByApi(
                      context, category.copyWith(hideQueue: value));
                },
              ),
            ],
          ),
          Divider(
            color: AppColors.neutral80,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  final Widget child;
  const RoundedContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }

  Widget _buildDisplaySettings(BuildContext context, Store store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("這裡還有7個開關，但還沒做")
        // SwitchListTile(
        //   title: Text('顯示在接待畫面和外部顯示'),
        //   value: true, // 根据实际情况设定开关状态
        //   onChanged: (value) {
        //     // 更新开关状态
        //   },
        // ),
        // SwitchListTile(
        //   title: Text('顯示在店鋪模式接待一覽'),
        //   value: false, // 根据实际情况设定开关状态
        //   onChanged: (value) {
        //     // 更新开关状态
        //   },
        // ),
        // SwitchListTile(
        //   title: Text('顯示在Web店鋪詳細頁'),
        //   value: false, // 根据实际情况设定开关状态
        //   onChanged: (value) {
        //     // 更新开关状态
        //   },
        // ),
        // SwitchListTile(
        //   title: Text('顯示在Web等待狀態確認頁'),
        //   value: true, // 根据实际情况设定开关状态
        //   onChanged: (value) {
        //     // 更新开关状态
        //   },
        // ),
      ],
    );
  }
}
