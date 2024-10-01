import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/models/admin/business_hour.dart';
import 'package:qswait/pages/admin/widgets/business_hour_input.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';

@RoutePage()

///開店時間設定頁面
class WaitingTime extends ConsumerStatefulWidget {
  const WaitingTime({super.key});

  @override
  ConsumerState<WaitingTime> createState() => _WaitingTimeState();
}

class _WaitingTimeState extends ConsumerState<WaitingTime> {
  List<BusinessHour> businessHours = [];
  List<BusinessHour> originalBusinessHours = [];
  bool isLoading = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadBusinessHours();
  }

  // Future<void> _loadBusinessHours() async {
  //   final storeId = ref.read(storeProvider).value?.storeId ?? '';
  //   final response = await getStoreReceptionHours(storeId);
  //   if (response.success) {
  //     setState(() {
  //       businessHours = response.data?.businessHours ?? [];
  //       originalBusinessHours = List.from(businessHours);
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('加載店鋪資訊時出錯: ${response.message}')));
  //   }
  // }
  Future<void> _loadBusinessHours() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    final response = await getStoreReceptionHours(storeId);
    if (response.success) {
      setState(() {
        businessHours = response.data?.businessHours ?? [];
        originalBusinessHours = List.from(businessHours);
        isLoading = false;
      });
      ref
          .read(businessHoursProvider.notifier)
          .updateBusinessHours(businessHours);
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加載店鋪資訊時出錯: ${response.message}')));
    }
  }

  // void _addBusinessHour() {
  //   setState(() {
  //     businessHours.add(BusinessHour(startTime: '', endTime: ''));
  //   });
  // }

  // void _updateBusinessHour(int index, BusinessHour newHour) {
  //   setState(() {
  //     businessHours[index] = newHour;
  //   });
  //   ref.read(businessHoursProvider.notifier).updateBusinessHours(businessHours);
  // }

  // void _removeBusinessHour(int index) {
  //   setState(() {
  //     businessHours.removeAt(index);
  //   });
  //   ref.read(businessHoursProvider.notifier).updateBusinessHours(businessHours);
  // }

  // Future<void> _saveReceptionHours() async {
  //   final storeId = ref.read(storeProvider).value?.storeId ?? '';
  //   final request = StoreReceptionHoursRequest(
  //     storeId: storeId,
  //     // operation: 'Y',
  //     businessHours: businessHours,
  //   );
  //   final response = await updateReceptionHours(request);

  //   if (response.success) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('保存成功')));
  //     setState(() {
  //       isEditing = false;
  //       originalBusinessHours = List.from(businessHours);
  //     });
  //   } else {
  //     if (response.message == "End time is less than start time") {
  //       ///showdialog
  //       showDialog(
  //           context: context,
  //           builder: (context) => AlertDialog(
  //                 title: Text('設定錯誤'),
  //                 content: Text('結束時間必須大於開始時間'),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     child: Text('確認'),
  //                   ),
  //                 ],
  //               ));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('保存失敗: ${response.message}')));
  //     }
  //   }
  // }

  // void _cancelEditing() {
  //   setState(() {
  //     businessHours = List.from(originalBusinessHours);
  //     isEditing = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(storeProvider);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('接待時間設置'),
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : store.when(
              data: (store) => Container(
                height: double.infinity,
                color: AppColors.neutral94,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      adminPageTitle("接待時間設置"),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '開店時間',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            RoundedContainer(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('開店時間'),
                                    subtitle: Text('設置開店時間，開啟時根據時間設置開店時間'),
                                    trailing: Switch(
                                      value: store.businessHoursTime == "Y",
                                      onChanged: (bool newValue) {
                                        ref
                                            .read(storeProvider.notifier)
                                            .updateModeSwitch(
                                              AdminModeAction.businessHoursTime,
                                              newValue ? "Y" : "N",
                                            );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      thickness: 1.5,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            EditBusinessHoursPage(
                                          businessHours: businessHours,
                                          originalBusinessHours:
                                              originalBusinessHours,
                                        ),
                                      ));
                                      await _loadBusinessHours();
                                      // setState(() {
                                      //   isEditing = !isEditing;
                                      //   if (!isEditing) {
                                      //     _cancelEditing();
                                      //   }
                                      // });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.transparent),
                                        overlayColor: WidgetStateProperty.all(
                                          Colors.transparent,
                                        ),
                                        shadowColor: WidgetStateProperty.all(
                                          Colors.transparent,
                                        )),
                                    child: Text(
                                      '編輯接待時間',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColors.primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 16),
                            // SizedBox(height: 16),
                            // if (isEditing)
                            //   RoundedContainer(
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         ...businessHours
                            //             .asMap()
                            //             .entries
                            //             .map((entry) {
                            //           final index = entry.key;
                            //           final businessHour = entry.value;
                            //           return Row(
                            //             children: [
                            //               IconButton(
                            //                 icon: Icon(Icons.cancel,
                            //                     color: Colors.red),
                            //                 onPressed: () =>
                            //                     _removeBusinessHour(index),
                            //               ),
                            //               Expanded(
                            //                 child: BusinessHourInput(
                            //                   businessHour: businessHour,
                            //                   onChanged: (newHour) =>
                            //                       _updateBusinessHour(
                            //                           index, newHour),
                            //                 ),
                            //               ),
                            //             ],
                            //           );
                            //         }).toList(),
                            //         SizedBox(height: 16),
                            //         SizedBox(height: 16),
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceEvenly,
                            //           children: [
                            //             ElevatedButton(
                            //               onPressed: _cancelEditing,
                            //               child: Text('取消'),
                            //             ),
                            //             ElevatedButton(
                            //               onPressed: _saveReceptionHours,
                            //               child: Text('保存'),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // if (isEditing)
                            //   RoundedContainer(
                            //   child: ElevatedButton(
                            //     onPressed: _addBusinessHour,
                            //     child: Row(
                            //       children: [
                            //         Icon(
                            //           Icons.add_circle,
                            //           color: AppColors.addCircle,
                            //         ),
                            //         Text(' 新增接待時間'),
                            //       ],
                            //     ),
                            //     style: ButtonStyle(
                            //         backgroundColor: WidgetStateProperty.all(
                            //             Colors.transparent),
                            //         overlayColor: WidgetStateProperty.all(
                            //           Colors.transparent,
                            //         ),
                            //         shadowColor: WidgetStateProperty.all(
                            //           Colors.transparent,
                            //         )),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('讀取店鋪資料失敗: $error')),
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
}

class EditBusinessHoursPage extends ConsumerStatefulWidget {
  final List<BusinessHour> businessHours;
  final List<BusinessHour> originalBusinessHours;

  const EditBusinessHoursPage({
    required this.businessHours,
    required this.originalBusinessHours,
  });

  @override
  _EditBusinessHoursPageState createState() => _EditBusinessHoursPageState();
}

class _EditBusinessHoursPageState extends ConsumerState<EditBusinessHoursPage> {
  late List<BusinessHour> businessHours;
  late List<BusinessHour> originalBusinessHours;

  @override
  void initState() {
    super.initState();
    businessHours = List.from(widget.businessHours);
    originalBusinessHours = List.from(widget.originalBusinessHours);
    // _loadBusinessHours();
  }

  void _addBusinessHour() {
    setState(() {
      businessHours.add(BusinessHour(startTime: '', endTime: ''));
    });
  }

  void _updateBusinessHour(int index, BusinessHour newHour) {
    setState(() {
      businessHours[index] = newHour;
    });
    ref.read(businessHoursProvider.notifier).updateBusinessHours(businessHours);
  }

  void _removeBusinessHour(int index) {
    setState(() {
      businessHours.removeAt(index);
    });
    ref.read(businessHoursProvider.notifier).updateBusinessHours(businessHours);
  }

  Future<void> _loadBusinessHours() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    final response = await getStoreReceptionHours(storeId);
    if (response.success) {
      setState(() {
        businessHours = response.data?.businessHours ?? [];
        originalBusinessHours = List.from(businessHours);
      });
      ref
          .read(businessHoursProvider.notifier)
          .updateBusinessHours(businessHours);
    } else {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加載店鋪資訊時出錯: ${response.message}')));
    }
  }

  Future<void> _saveReceptionHours() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    final request = StoreReceptionHoursRequest(
      storeId: storeId,
      businessHours: businessHours,
    );
    final response = await updateReceptionHours(request);

    if (response.success) {
      // _loadBusinessHours();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('保存成功')));
      setState(() {
        originalBusinessHours = List.from(businessHours);
      });
    } else {
      if (response.message == "End time is less than start time") {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('設定錯誤'),
                  content: Text('結束時間必須大於開始時間'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('確認'),
                    ),
                  ],
                ));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('儲存失敗: ${response.message}')));
      }
    }
  }

  void _cancelEditing() {
    setState(() {
      businessHours = List.from(originalBusinessHours);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackPressed: () {
          Navigator.of(context).pop();
        },
        title: "編輯商店接待時間",
        onSavePressed: () {
          _saveReceptionHours();
        },
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.neutral94,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(3.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (businessHours.isEmpty)
                      Text(
                        '無設定接待時間',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                    ...businessHours.asMap().entries.map((entry) {
                      final index = entry.key;
                      final businessHour = entry.value;
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 3.sp),
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: AppColors.removeColor,
                              size: 8.sp,
                            ),
                            onPressed: () => _removeBusinessHour(index),
                          ),
                          title: BusinessHourInput(
                            businessHour: businessHour,
                            onChanged: (newHour) =>
                                _updateBusinessHour(index, newHour),
                          ),
                        ),
                      );
                    }).toList(),
                    // SizedBox(height: 16),
                    RoundedContainer(
                      child: ElevatedButton(
                        onPressed: _addBusinessHour,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0.sp),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: AppColors.addCircle,
                                size: 8.sp,
                              ),
                              Padding(
                                padding: EdgeInsets.all(3.0.sp),
                                child: Text(
                                  '新增接待時間',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.transparent),
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            shadowColor: WidgetStateProperty.all(
                              Colors.transparent,
                            )),
                      ),
                    ),
                    Text(
                      "如果您設定的結束時間早於開始時間，則結束時間將為第二天。",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackPressed;
  final Function onSavePressed;

  CustomAppBar(
      {required this.title,
      required this.onBackPressed,
      required this.onSavePressed});

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
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        "儲存",
                        style: TextStyle(
                            fontSize: 6.8.sp, color: AppColors.primaryColor),
                      ),
                      onPressed: () => onSavePressed(),
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
