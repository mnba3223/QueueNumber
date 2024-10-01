import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/navigation_helper.dart';

@RoutePage()
class NotePadPage extends ConsumerStatefulWidget {
  const NotePadPage({super.key});

  @override
  ConsumerState<NotePadPage> createState() => _NotePadPageState();
}

class _NotePadPageState extends ConsumerState<NotePadPage> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(currentCustomerProvider);
    final navigationHelper = NavigationHelper(ref, context);
    final store = ref.watch(storeProvider);
    // AsyncValue<bool> showNotePage =
    return Container();
  }
}
