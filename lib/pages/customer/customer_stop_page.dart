import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/admin_Action.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/widgets/num_pad/numeric_pad.dart';

@RoutePage()
class CustomerStopPage extends ConsumerWidget {
  const CustomerStopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 當前選擇狀態，可以從 provider 獲取
    final store = ref.watch(storeProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('本日停止發卷'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: store.when(
            data: (storeData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '本日停止發卷',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final result = await showDialog<bool>(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //         title: Text('確認'),
                  //         content: Text('確定要停止發卷嗎？'),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             onPressed: () => Navigator.of(context).pop(false),
                  //             child: Text('取消'),
                  //           ),
                  //           TextButton(
                  //             onPressed: () => Navigator.of(context).pop(true),
                  //             child: Text('確認'),
                  //           ),
                  //         ],
                  //       ),
                  //     );

                  //     if (result == true) {
                  //       // 在這裡執行停止發卷的邏輯
                  //       // 例如，調用 API 來更新服務器狀態
                  //       ref.read(storeProvider.notifier).updateModeSwitch(
                  //           AdminModeAction.stopIssuingTickets, 'Y');
                  //     }
                  //   },
                  //   child: Text('停止發卷'),
                  // ),
                ],
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            store.when(
              data: (storeData) {
                // 傳遞 顧客模式
                ref.read(adminPageProvider.notifier).setSelectedMode("顧客模式");
                return showNumericPadDialog(context, AdminRoute(),
                    storeId: storeData.storeId);
              },
              loading: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) =>
                      Center(child: CircularProgressIndicator()),
                );
              },
              error: (error, stackTrace) async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to load store data: $error'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
                AutoRouter.of(context).replace(AdminRoute());
              },
            );
          },
          child: Icon(Icons.settings, color: Colors.black54),
          backgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightElevation: 0,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
