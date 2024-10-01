import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/services/riverpod_state_management.dart';

class StoreEditPage extends ConsumerStatefulWidget {
  final Category? category;
  final Function(Category) onSubmit;
  final VoidCallback? onDelete;

  StoreEditPage({
    this.category,
    required this.onSubmit,
    this.onDelete,
  });

  @override
  _StoreEditPageState createState() => _StoreEditPageState();
}

class _StoreEditPageState extends ConsumerState<StoreEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _queueTypeNameController;
  late TextEditingController _queuePeopleMinController;
  late TextEditingController _queuePeopleMaxController;
  late TextEditingController _queueNumTitleController;
  late TextEditingController _waitingTimeController;
  late TextEditingController _intervalTimeController;

  @override
  void initState() {
    super.initState();
    _queueTypeNameController = TextEditingController(
      text: widget.category?.queueTypeName ?? '',
    );
    _queuePeopleMinController = TextEditingController(
      text: widget.category?.queuePeopleMin.toString() ?? '0',
    );
    _queuePeopleMaxController = TextEditingController(
      text: widget.category?.queuePeopleMax.toString() ?? '0',
    );
    _queueNumTitleController = TextEditingController(
      text: widget.category?.queueNumTitle ?? '',
    );
    _waitingTimeController = TextEditingController(
      text: widget.category?.waitingTime.toString() ?? '0',
    );
    _intervalTimeController = TextEditingController(
      text: widget.category?.intervalTime.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _queueTypeNameController.dispose();
    _queuePeopleMinController.dispose();
    _queuePeopleMaxController.dispose();
    _queueNumTitleController.dispose();
    _waitingTimeController.dispose();
    _intervalTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final store = ref.read(storeProvider);
    final isEdit = widget.category != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '編輯分類' : '新增分類'),
        actions: [
          // if (isEdit)
          //   IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: widget.onDelete,
          //   ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _queueTypeNameController,
                decoration: InputDecoration(labelText: '分類名稱'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入分類名稱';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _queuePeopleMinController,
                decoration: InputDecoration(labelText: '最小人數'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入最小人數';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _queuePeopleMaxController,
                decoration: InputDecoration(labelText: '最大人數'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入最大人數';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _queueNumTitleController,
                decoration: InputDecoration(labelText: '隊列標題'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入隊列標題';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _waitingTimeController,
                decoration: InputDecoration(labelText: '等待時間 (分鐘)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入等待時間';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: _intervalTimeController,
              //   decoration: InputDecoration(labelText: '第二組以後等待時間 (分鐘)'),
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return '請輸入第二組以後等待時間';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final store = ref.read(storeProvider);
                    store.whenData((storeData) {
                      final newCategory = Category(
                        id: widget.category?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        storeId: storeData.storeId,
                        queueType: widget.category?.queueType ?? 0,
                        queueTypeName: _queueTypeNameController.text,
                        queuePeopleMin:
                            int.parse(_queuePeopleMinController.text),
                        queuePeopleMax:
                            int.parse(_queuePeopleMaxController.text),
                        queueNumTitle: _queueNumTitleController.text,
                        defaultQueue: widget.category?.defaultQueue ?? 0,
                        waitingTime: int.parse(_waitingTimeController.text),
                        intervalTime: int.parse(_intervalTimeController.text),
                        hideQueue: widget.category?.hideQueue ?? false,
                      );
                      widget.onSubmit(newCategory);
                    });
                  }
                },
                child: Text(isEdit ? '保存' : '新增'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
