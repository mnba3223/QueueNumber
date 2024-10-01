import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/pages/admin/style/textstyle.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';
import 'package:qswait/widgets/num_pad/numeric_pad.dart';

@RoutePage()
class BasicConfigPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);

    return store.when(
      data: (store) => Scaffold(
        body: Container(
          color: AppColors.neutral94,
          child: SingleChildScrollView(
            child: Column(
              children: [
                adminPageTitle("基本設定"),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle('店家資訊'),
                      RoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpansionTile(
                              title: AdminTextSetting.adminTextStyle('基本資料'),
                              children: [
                                ListTile(
                                  title: Text('店名: ${store.storeName}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('店號: ${store.storeId}'),
                                      Text('聯絡人: ${store.contactUser ?? ''}'),
                                      Text('聯絡郵件: ${store.contactEmail ?? ''}'),
                                      Text('聯絡電話: ${store.contactPhone ?? ''}'),
                                      Text('地址: ${store.storeAdd ?? ''}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ConfigListTile(
                              title: '後台密碼變更',
                              onTap: () {
                                showNewPasswordDialog(context, store.storeId);
                              },
                            ),
                          ],
                        ),
                      ),
                      SectionTitle('等待設定'),
                      RoundedContainer(
                        child: ConfigListTile(
                          title: '等待組數或者等待人數的顯示',
                          trailing: Text(
                              "顯示等待${store.showGroupsOrPeople == 'group' ? '組' : '人'}數",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppColors.neutral60,
                                      fontWeight: FontWeight.bold)),
                          onTap: () async {
                            AutoRouter.of(context).push(WaitSettingRoute());
                          },
                        ),
                      ),
                      SectionTitle('對應中使用'),
                      RoundedContainer(
                        child: ConfigSwitchListTile(
                          title: '使用對應中標籤',
                          value: store.extendedMode == 'Y',
                          onChanged: (value) {
                            _updateExtendedMode(context, ref, store, value);
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      SectionTitle('確認畫面省略'),
                      RoundedContainer(
                        child: ConfigSwitchListTile(
                          title: '省略確認畫面',
                          subtitle: '當點擊確認按鈕為on時會出現確認畫面',
                          value: store.skipConfirmationScreen == 'N',
                          onChanged: (value) {
                            ref.read(storeProvider.notifier).updateModeSwitch(
                                  AdminModeAction.skipConfirmationScreen,
                                  value ? 'N' : 'Y',
                                );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      SectionTitle('其他設定'),
                      RoundedContainer(
                        child: ConfigSwitchListTile(
                          title: '自動取號',
                          value: store.autoTakeNumber == 'Y',
                          onChanged: (value) {
                            _updateModeSwitch(
                              context,
                              ref,
                              store,
                              AdminModeAction.autoTakeNumber,
                              value ? 'Y' : 'N',
                            );
                          },
                        ),
                      ),
                      SectionTitle('叫號等待超時設定'),
                      RoundedContainer(
                        child: Column(
                          children: [
                            ConfigSwitchListTile(
                              title: '顯示等候超時警告',
                              value: store.showWaitingAlerts == 'Y',
                              onChanged: (value) {
                                // 顯示等候超時警告的操作
                                ref
                                    .read(storeProvider.notifier)
                                    .updateModeSwitch(
                                      AdminModeAction.showWaitingAlerts,
                                      value ? 'Y' : 'N',
                                    );
                              },
                            ),
                            ConfigListTile(
                              title: '強調顯示超過時間',
                              trailing:
                                  Text("顯示${store.highlightOverTime}分鐘以上"),
                              enabledIcon: false,
                              onTap: () async {
                                // 強調顯示超過時間的操作
                                final updateTime = await showMinutePickerDialog(
                                    context,
                                    store
                                        .highlightOverTime); // 你可以根據需要自定義此對話框以選擇時間
                                if (updateTime != null) {
                                  await ref
                                      .read(storeProvider.notifier)
                                      .updateAdminAboutTime(
                                          updateTime.toString(),
                                          'highlightOverTime');
                                }
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
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('加载店铺信息时出错: $e')),
    );
  }
}

Future<int?> showMinutePickerDialog(
    BuildContext context, int? selectedMinute) async {
  selectedMinute = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return MinutePickerDialog(selectedMinute: selectedMinute);
    },
  );
  return selectedMinute;
}

class MinutePickerDialog extends StatefulWidget {
  int? selectedMinute;

  MinutePickerDialog({super.key, this.selectedMinute});
  @override
  _MinutePickerDialogState createState() => _MinutePickerDialogState();
}

class _MinutePickerDialogState extends State<MinutePickerDialog> {
  // int _selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('選擇分鐘數'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButton<int>(
            value: widget.selectedMinute,
            items: List.generate(60, (index) => index).map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.selectedMinute = value!;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('確認'),
          onPressed: () {
            Navigator.of(context).pop(widget.selectedMinute);
          },
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 10),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 18),
      ),
    );
  }
}

class ConfigListTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  bool enabledIcon = true;

  ConfigListTile({
    required this.title,
    this.trailing,
    this.onTap,
    this.enabledIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.CommonText),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailing != null) trailing!,
                SizedBox(width: 8),
                enabledIcon
                    ? Icon(Icons.arrow_forward_ios_rounded)
                    : Container(),
              ],
            ),
          ],
        ),
      ),
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
      title: AdminTextSetting.adminTextStyle(title),
      subtitle: subtitle != null
          ? Text(subtitle!, style: TextStyle(color: Colors.grey[500]))
          : null,
      value: value,
      onChanged: onChanged,
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
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}

/// 擴展模式
Future<void> _updateExtendedMode(
    BuildContext context, WidgetRef ref, Store store, bool value) async {
  final response = await updateExtendedMode(store.id, value);
  if (response.success) {
    ref.read(storeProvider.notifier).updateStore(
          store.copyWith(extendedMode: value ? 'Y' : 'N'),
        );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to update extended mode: ${response.message}'),
      ),
    );
  }
}

///後台各式設定
Future<void> _updateModeSwitch(
  BuildContext context,
  WidgetRef ref,
  Store store,
  AdminModeAction action,
  String modeSwitchValue,
) async {
  final customerPageNotifier = ref.read(customerPageProvider.notifier);
  final response = await updateAdminModeSwitch(store, action, modeSwitchValue);
  if (response.success) {
    Store? updatedStore;
    switch (action) {
      case AdminModeAction.numberOfPeople:
        updatedStore = store.copyWith(numberOfPeople: modeSwitchValue);
        if (modeSwitchValue != 'Y') {
          customerPageNotifier.resetPages();
        }
        break;
      case AdminModeAction.adultsAndChildren:
        updatedStore = store.copyWith(adultsAndChildren: modeSwitchValue);
        break;
      case AdminModeAction.autoTakeNumber:
        updatedStore = store.copyWith(autoTakeNumber: modeSwitchValue);
        break;
      case AdminModeAction.showGroupsOrPeople:
        updatedStore = store.copyWith(showGroupsOrPeople: modeSwitchValue);
        break;
      case AdminModeAction.hideQueue:
        break;
      default:
        break;
    }
    if (updatedStore != null) {
      ref.read(storeProvider.notifier).updateStore(updatedStore);
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to update mode: ${response.message}'),
      ),
    );
  }
}
