import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/services/riverpod_state_management.dart';

class RefreshNotifier extends StateNotifier<bool> {
  Timer? _timer;

  RefreshNotifier() : super(false);

  void start(WidgetRef ref) {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) {
        ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
        ref.read(storeProvider.notifier).fetchStoreInfo();
        ref.read(categoryProvider.notifier).fetchCategoriesFromApi();
      });
      state = true;
    }
  }

  void refreshData(WidgetRef ref) {
    ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
    ref.read(storeProvider.notifier).fetchStoreInfo();
    ref.read(categoryProvider.notifier).fetchCategoriesFromApi();
  }

  void stop() {
    _timer?.cancel();
    state = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
