// 示例的“三种模式选择页面”
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';

@RoutePage()
class MainSettingPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<MainSettingPage> createState() => _MainSettingPageState();
}

class _MainSettingPageState extends ConsumerState<MainSettingPage> {
  // List<String> modeRoutes = ['/multiple_merchant', '/customer', '/customer'];
  // List<String> modeTexts = ["店家模式", "顧客模式", "店舖外"];
  List<String> modeTexts = ["店家模式", "顧客模式"];
  List<IconData> modeIcons = [
    Icons.store_mall_directory,
    Icons.emoji_people_outlined
  ];
  @override
  Widget build(BuildContext context) {
    // final isRefreshing = ref.watch(refreshProvider);
    final selectedMode = ref.watch(adminPageProvider);
    final store = ref.watch(storeProvider);

    ///停止取號
    final stopTakingNumbers = store.maybeWhen(
      data: (data) => data.stopTakingNumbers == 'N',
      orElse: () => false,
    );

    ///關閉店鋪
    final closeStore = store.maybeWhen(
      data: (data) => data.frontEndClosed == 'N',
      orElse: () => false,
    );
    return store.when(data: (storeData) {
      return Container(
        color: AppColors.neutral94,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              adminPageTitle("主選單"),
              // SizedBox(height: 20),
              // 上半部分
              Container(
                color: AppColors.White,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // _buildOptionButton(context, Icons.person_add, '插隊登記'),
                    _buildOptionButton(
                      context,
                      stopTakingNumbers
                          ? 'assets/images/icon/icon-dashboard02.svg'
                          : 'assets/images/icon/icon-dashboard08.svg',
                      stopTakingNumbers ? '停止' : '恢復票務',
                      toplabel: "今日票務",
                      onPressed: () {
                        _showConfirmTakingNumbersDialog(
                            context, stopTakingNumbers ? '停止票務' : '恢復票務', () {
                          ref.read(storeProvider.notifier).updateModeSwitch(
                                AdminModeAction.stopTakingNumbers,
                                stopTakingNumbers ? 'Y' : 'N',
                              );
                        },
                            content: stopTakingNumbers
                                ? '今天不再接受新的申請，確認嗎?'
                                : '恢復接受票據申請，確認嗎?');
                      },
                      isActive: !stopTakingNumbers,
                    ),
                    _buildOptionButton(
                      context,
                      closeStore
                          ? 'assets/images/icon/icon-dashboard03.svg'
                          : 'assets/images/icon/icon-dashboard07.svg',
                      closeStore ? '停止' : '開啟店鋪',
                      toplabel: "門市服務",
                      onPressed: () {
                        _showConfirmCloseStoreDialog(
                            context, closeStore ? '停止門市服務' : '開啟店鋪', () {
                          ref.read(storeProvider.notifier).updateModeSwitch(
                                AdminModeAction.frontEndClosed,
                                closeStore ? 'Y' : 'N',
                              );
                        },
                            content: closeStore
                                ? '所有與接待相關的功能將被暫停，確認嗎?'
                                : '開啟門市服務，確認嗎?');
                      },
                      isActive: !closeStore,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              // 中间部分的三个模式选项
              Container(
                // color: AppColors.neutral90,
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  "裝置設定",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: AppColors.CommonText),
                ),
              ),
              showMiddleBlock(selectedMode, storeData),
              SizedBox(height: 20),
              // 下半部分

              // 加入浮动按钮
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: FloatingActionButton(
              //     onPressed: () {
              //       if (isRefreshing) {
              //         ref.read(refreshProvider.notifier).stop();
              //       } else {
              //         ref.read(refreshProvider.notifier).start(ref);
              //       }
              //     },
              //     child: Icon(isRefreshing ? Icons.pause : Icons.play_arrow),
              //   ),
              // ),
            ],
          ),
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return Container();
    }, loading: () {
      return Container();
    });
  }

  Widget showMiddleBlock(String? selectedMode, Store storeData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.neutral96,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(2, (index) {
              bool isSelected = selectedMode == modeTexts[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMode = modeTexts[index];
                    ref
                        .read(adminPageProvider.notifier)
                        .setSelectedMode(modeTexts[index]);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 5.sp),
                    Stack(
                      children: [
                        SvgPicture.asset(
                          'assets/images/icon/icon-dashboard0${index + 4}.svg',
                          colorFilter: ColorFilter.mode(
                              isSelected ? Colors.orange : Colors.black,
                              BlendMode.srcIn),
                          height: 15.sp,
                          width: 15.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: isSelected
                            ? Border.all(color: Colors.orange)
                            : null,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          modeTexts[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected ? Colors.orange : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    if (isSelected)
                      CustomPaint(
                        size: Size(10.sp, 10.sp),
                        painter: TrianglePainter(),
                      ),
                    if (!isSelected)
                      SizedBox(
                        height: 10.sp,
                      )
                  ],
                ),
              );
            }),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '店家設定',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: AppColors.neutral60,
                  ),
                  ConfigSwitchListTile(
                      title: '有新客戶通知店家',
                      value: storeData.notifyTheReceptionist == 'Y',
                      onChanged: (value) {
                        ref.read(storeProvider.notifier).updateModeSwitch(
                              AdminModeAction.notifyTheReceptionist,
                              value ? 'Y' : 'N',
                            );
                      }),
                  ConfigSwitchListTile(
                      title: '等待畫面設定',
                      value: storeData.screenSaver == 'Y',
                      onChanged: (value) {
                        ref.read(storeProvider.notifier).updateModeSwitch(
                              AdminModeAction.screenSaver,
                              value ? 'Y' : 'N',
                            );
                      }),
                  if (storeData.screenSaver == 'Y')
                    ListTile(
                      title: Center(
                          child: Text(
                        '編輯等待文字畫面',
                        style: TextStyle(color: AppColors.primaryColor),
                      )),
                      onTap: () {
                        context.router.push(EditTextRouteRoute());
                      },
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String iconPath, String label,
      {String toplabel = "",
      required Function onPressed,
      required bool isActive}) {
    return Column(
      children: [
        SizedBox(height: 5.sp),
        Text(
          toplabel,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.CommonText),
        ),
        SizedBox(height: 5.sp),
        SvgPicture.asset(
          iconPath,
          width: 15.sp,
          height: 15.sp,
        ),
        SizedBox(height: 5.sp),
        ElevatedButton(
          onPressed: () {
            onPressed();
          },
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.sp, vertical: 2.3.sp),
                // margin: EdgeInsets.only(top: 5.sp),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 6.sp,
                      color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            // shape: CircleBorder(),
            // padding: EdgeInsets.all(20),
            // elevation: 0,
            backgroundColor: Colors.white,
            disabledBackgroundColor: Colors.transparent,

            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            // foregroundColor: Colors.white,
            // disabledForegroundColor: Colors.transparent,
            // side: BorderSide(color: AppColors.primaryColor),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        SizedBox(height: 5.sp),
      ],
    );
  }

  void _showConfirmTakingNumbersDialog(
      BuildContext context, String title, Function onConfirm,
      {String content = ""}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
          )),
          // content: Text('確定要$label嗎？'),
          content: Text('$content'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _showLoadingDialog(context); // Show loading dialog
                    await onConfirm();
                    Navigator.of(context).pop(); // Close loading dialog
                  },
                  child: Text('確認'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showConfirmCloseStoreDialog(
      BuildContext context, String title, Function onConfirm,
      {String content = ""}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.black, fontWeight: FontWeight.bold),
          )),
          content: Text('$content'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    _showLoadingDialog(context); // Show loading dialog
                    await onConfirm();
                    Navigator.of(context).pop(); // Close loading dialog
                  },
                  child: Text('確認'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildToggleOption(String label, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Switch(
          value: value,
          onChanged: (bool newValue) {
            // Handle toggle switch
          },
        ),
      ],
    );
  }
}

class ConfigSwitchListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ConfigSwitchListTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.CommonText),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: TextStyle(color: Colors.grey[500]))
          : null,
      value: value,
      onChanged: onChanged,
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 5)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
