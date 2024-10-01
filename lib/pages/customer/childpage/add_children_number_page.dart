import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/pages/customer/widgets/NumberPad.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/navigation_helper.dart';

@RoutePage()
class AddChildrenNumberPage extends ConsumerStatefulWidget {
  const AddChildrenNumberPage({super.key});

  @override
  ConsumerState<AddChildrenNumberPage> createState() =>
      _AddChildrenNumberPageState();
}

class _AddChildrenNumberPageState extends ConsumerState<AddChildrenNumberPage> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(currentCustomerProvider);
    final navigationHelper = NavigationHelper(ref, context);

    return NumberInputWidget(
      title: '輸入小孩人數',
      unit: '位',
      initialNumber: customer?.numberOfChild ?? 0,
      onChanged: (number) {
        ref.read(currentCustomerProvider.notifier).setCustomer(
              customer!.copyWith(numberOfChild: number),
            );
      },
      onNext: () {
        navigationHelper.navigateToNextPage(needCheckNumber: true);
      },
    );
  }
}
