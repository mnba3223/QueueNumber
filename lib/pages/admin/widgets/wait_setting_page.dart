import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/services/riverpod_state_management.dart';

@RoutePage()
class WaitSettingPage extends ConsumerWidget {
  const WaitSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 當前選擇狀態，可以從 provider 獲取
    final store = ref.watch(storeProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('等待設置'),
        ),
        body: store.when(
          data: (data) {
            return ListView(
              children: [
                ListTile(
                  title: Text('等待組數'),
                  trailing: data.showGroupsOrPeople == "groups"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    // ref.read(storeProvider.notifier).updateStore(
                    //     data.copyWith(showGroupsOrPeople: "groups"));
                    ref.read(storeProvider.notifier).updateModeSwitch(
                        AdminModeAction.showGroupsOrPeople, "groups");
                    // Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text('等待人數'),
                  trailing: data.showGroupsOrPeople == "people"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(storeProvider.notifier).updateModeSwitch(
                        AdminModeAction.showGroupsOrPeople, "people");
                    // Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
          error: (Object error, StackTrace stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return Text("loading");
          },
        ));
  }
}
