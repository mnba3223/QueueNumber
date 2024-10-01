import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/state/callingStatus.dart';
import 'package:qswait/models/state/queueStatus.dart';
import 'package:qswait/pages/marchant/widget/merchant_left_block.dart';

import 'package:qswait/pages/marchant/widget/merchant_right_block.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/api/customers_api.dart';
import 'package:qswait/services/api/merchant.dart';
import 'package:qswait/services/app_router.dart';
import 'package:qswait/services/app_router.gr.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/widgets/num_pad/numeric_pad.dart';

@RoutePage()
class MerchantMultipleMainPage extends ConsumerStatefulWidget {
  const MerchantMultipleMainPage({super.key});

  @override
  ConsumerState<MerchantMultipleMainPage> createState() =>
      _MerchantMultipleMainPageState();
}

class _MerchantMultipleMainPageState
    extends ConsumerState<MerchantMultipleMainPage> {
  String dropdownValue = 'AllCategory';
  QueueStatus? queueStatus = QueueStatusExtension.fromString('Waiting');
  bool _isDisposed = false;
  late CancelToken cancelToken;

  @override
  void initState() {
    super.initState();
    cancelToken = CancelToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        final storeId = ref.read(storeProvider).valueOrNull?.storeId;
        // fetchCustomersFromApi(ref, storeId!, cancelToken: cancelToken);
        // fetchStoreInfoFromApi(storeId);
        // fetchAllCategories(storeId);
        ref.read(refreshProvider.notifier).refreshData(ref);
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _checkForNewCustomerNotifications() {
    final unnotifiedCustomerIds =
        ref.read(customerQueueProvider.notifier).unnotifiedCustomerIds;
    final store = ref.read(storeProvider).value;
    final notifyTheReceptionist = store?.notifyTheReceptionist == 'Y';

    if (unnotifiedCustomerIds.isNotEmpty && notifyTheReceptionist) {
      ref.read(customerQueueProvider.notifier).clearNewCustomerNotifications();
      showDialog(
        context: getIt<AppRouter>().navigatorKey.currentState!.context,
        builder: (context) => AlertDialog(
          title: Text('新客戶通知'),
          content: Text('有新的客戶加入了隊列。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(customerQueueProvider.notifier)
                    .clearNewCustomerNotifications();
              },
              child: Text('確定'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final customerPageNotifier = ref.watch(customerPageProvider.notifier);
    final queueInfo = ref.watch(customerQueueProvider);
    final categories = ref
        .watch(categoryProvider)
        .categories
        .where((category) => category.hideQueue)
        .toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForNewCustomerNotifications();
      // _checkForNewCustomerNotifications();
    });
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            // statusBarColor: AppColors.primaryColor,
            // statusBarIconBrightness: Brightness.light,
            // Status bar brightness (optional)
            // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            // statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text('座位種類'),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryColor,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['AllCategory']
                    .followedBy(
                        categories.map((category) => category.queueTypeName))
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'AllCategory'
                          ? callingStatusLocalized(context, "allcategory")
                          : value,
                      // style: TextStyle(
                      //     color: AppColors.primaryColor,
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }).toList(),
                underline: Container(), // 去掉下划线
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.settings,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            ref.read(adminPageProvider.notifier).setSelectedMode("店家模式");
            return showNumericPadDialog(context, AdminRoute(),
                storeId: ref.read(storeProvider).valueOrNull?.storeId ?? '');
            // context.router.replace(AdminRoute());
          },
        ),
      ),
      body: Container(
        // color: Color.fromARGB(255, 247, 247, 247),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
                flex: 2, child: LeftBlockPage2(ref, dropdownValue, categories)),
            Expanded(
                flex: 1,
                child:
                    RightBlockPage(customerPageNotifier, queueInfo, categories))
          ],
        ),
      ),
    );
  }
}
