import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/services/riverpod_state_management.dart';

@RoutePage()
class WaitingTimeDisplay extends ConsumerWidget {
  const WaitingTimeDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 當前選擇狀態，可以從 provider 獲取
    final store = ref.watch(storeProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('全體等待時間顯示方式'),
        ),
        body: store.when(
          data: (storeData) {
            return ListView(
              children: [
                ListTile(
                  title: Text('根據最早呼叫時間等待項目的等待時間'),
                  trailing: storeData.allWaitingTimeDisplayed == "earliest"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(storeProvider.notifier).updateModeSwitch(
                        AdminModeAction.allWaitingTimeDisplayed, "earliest");
                  },
                ),
                ListTile(
                  title: Text('根據最遲呼叫時間等待項目的等待時間'),
                  trailing: storeData.allWaitingTimeDisplayed == "last"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(storeProvider.notifier).updateModeSwitch(
                        AdminModeAction.allWaitingTimeDisplayed, "last");
                  },
                ),
                ListTile(
                  title: Text('全部等待組別合計等待時間'),
                  trailing: storeData.allWaitingTimeDisplayed == "total"
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(storeProvider.notifier).updateModeSwitch(
                        AdminModeAction.allWaitingTimeDisplayed, "total");
                  },
                ),
              ],
            );
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        ));
  }
}
