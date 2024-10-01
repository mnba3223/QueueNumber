import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/store_text_screen.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';

@RoutePage()
class EditTextScreenPage extends ConsumerStatefulWidget {
  const EditTextScreenPage({super.key});

  @override
  ConsumerState<EditTextScreenPage> createState() => _EditTextScreenPageState();
}

class _EditTextScreenPageState extends ConsumerState<EditTextScreenPage> {
  TextEditingController _noOneQueuingController = TextEditingController();
  TextEditingController _someOneQueuingController = TextEditingController();
  TextEditingController _stopTakeNumberController = TextEditingController();
  TextEditingController _limitTakeNumberController = TextEditingController();
  int _textScreenId = 0;

  @override
  void initState() {
    super.initState();
    _loadStoreTextScreen();
  }

  Future<void> _loadStoreTextScreen() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    await ref
        .read(storeTextScreenProvider.notifier)
        .fetchStoreTextScreen(storeId);
    final storeTextScreen = ref.read(storeTextScreenProvider).maybeWhen(
          data: (data) => data,
          orElse: () => null,
        );
    if (storeTextScreen != null) {
      _noOneQueuingController.text = storeTextScreen.noOneQueuing;
      _someOneQueuingController.text = storeTextScreen.someOneQueuing;
      _stopTakeNumberController.text = storeTextScreen.stopTakeNumber;
      _limitTakeNumberController.text = storeTextScreen.limitTakeNumber;
      _textScreenId = storeTextScreen.id;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('載入資料失敗')),
      );
    }
  }

  Future<void> _saveStoreTextScreen() async {
    final storeId = ref.read(storeProvider).value?.storeId ?? '';
    final request = StoreTextScreenResponse(
      id: _textScreenId,
      storeId: storeId,
      noOneQueuing: _noOneQueuingController.text,
      someOneQueuing: _someOneQueuingController.text,
      stopTakeNumber: _stopTakeNumberController.text,
      limitTakeNumber: _limitTakeNumberController.text,
    );
    await ref
        .read(storeTextScreenProvider.notifier)
        .updateStoreTextScreenbyAPi(request);
    final response = ref.read(storeTextScreenProvider);
    if (response is AsyncData<StoreTextScreenResponse>) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('保存成功')));
      // Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('保存失敗')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final storeTextScreen = ref.watch(storeTextScreenProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: '待機畫面螢幕顯示文字',
        onBackPressed: () {
          Navigator.pop(context);
        },
        onSavePressed: _saveStoreTextScreen,
      ),
      body: storeTextScreen.when(
        data: (data) => Container(
          color: AppColors.neutral94,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Expanded(
                  child: _buildTextField(
                    '如果沒有等候名單',
                    _noOneQueuingController,
                    '請洽工作人員',
                  ),
                ),
                Expanded(
                  child: _buildTextField(
                    '如果有等候名單',
                    _someOneQueuingController,
                    '請觸碰螢幕以開始等候',
                  ),
                ),
                Expanded(
                  child: _buildTextField(
                    '如果接待時間已結束',
                    _stopTakeNumberController,
                    '今天的營業時間已結束了',
                  ),
                ),
                Expanded(
                  child: _buildTextField(
                    '如果已達到等待人數上限',
                    _limitTakeNumberController,
                    '今天已沒有空位',
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('加载店铺信息时出错: $error')),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackPressed;
  final Function onSavePressed;

  CustomAppBar(
      {required this.title,
      required this.onBackPressed,
      required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).appBarTheme.color,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      color: AppColors.primaryColor,
                      onPressed: () => onBackPressed(),
                    ),
                    Text(
                      "離開",
                      style: TextStyle(
                          fontSize: 18, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.primaryColor),
                ),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        "儲存",
                        style: TextStyle(
                            fontSize: 18, color: AppColors.primaryColor),
                      ),
                      onPressed: () => onSavePressed(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
