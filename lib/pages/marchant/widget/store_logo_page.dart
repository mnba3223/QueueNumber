import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Store_class.dart';

import 'package:qswait/services/riverpod_state_management.dart';

class StoreLogoPage extends ConsumerStatefulWidget {
  // final Store store;
  const StoreLogoPage({super.key});

  @override
  _StoreLogoPageState createState() => _StoreLogoPageState();
}

class _StoreLogoPageState extends ConsumerState<StoreLogoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(storeProvider.notifier).fetchAndCacheStoreLogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeLogo = ref.read(storeProvider.notifier).storeLogo;
    // final storeLogo = widget.store;

    return storeLogo != null
        ? InkWell(
            onTap: () {
              // 点击事件
            },
            child: Image.memory(
              storeLogo,
              width: 50,
              height: 50,
              fit: BoxFit.fill,
              // gaplessPlayback: false,
            ),
          )
        : const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          );
  }
}

Widget buildLogoWidget(WidgetRef ref) {
  final storeLogo = ref.read(storeProvider.notifier).storeLogo;
  return storeLogo != null
      ? InkWell(
          onTap: () {
            // 点击事件
          },
          child: Image.memory(
            storeLogo,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            // gaplessPlayback: false,
          ),
        )
      : const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        );
}
