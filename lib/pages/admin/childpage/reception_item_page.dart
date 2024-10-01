import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/pages/admin/style/textstyle.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/UI.dart';

@RoutePage()
class ReceptionItemPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(storeProvider);

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.neutral94,
        child: Column(
          children: [
            adminPageTitle("接待項目"),
            store.when(
              data: (store) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle('接待項目'),
                      RoundedContainer(
                        child: Column(
                          children: [
                            ConfigSwitchListTile(
                              title: '顯示人數',
                              value: store.numberOfPeople == 'N',
                              onChanged: (value) {
                                ref
                                    .read(storeProvider.notifier)
                                    .updateModeSwitch(
                                      AdminModeAction.numberOfPeople,
                                      value ? 'N' : 'Y',
                                    );
                              },
                            ),
                            ConfigSwitchListTile(
                              title: '顯示大人小孩人數',
                              value: store.adultsAndChildren == 'Y',
                              onChanged: (value) {
                                ref
                                    .read(storeProvider.notifier)
                                    .updateModeSwitch(
                                      AdminModeAction.adultsAndChildren,
                                      value ? 'Y' : 'N',
                                    );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      SectionTitle('備忘錄設定'),
                      RoundedContainer(
                        child: ConfigSwitchListTile(
                          title: '開啟備忘錄',
                          value: store.useNotepad == 'Y',
                          onChanged: (value) {
                            ref.read(storeProvider.notifier).updateModeSwitch(
                                  AdminModeAction.useNotepad,
                                  value ? 'Y' : 'N',
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('加载店铺信息时出错: $e')),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
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

  const ConfigListTile({
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_forward),
      onTap: onTap,
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
