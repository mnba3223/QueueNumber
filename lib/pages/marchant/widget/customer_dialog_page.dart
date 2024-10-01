import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/admin/Category_Class.dart';
import 'package:qswait/models/customer/Customer_class.dart';

import 'package:qswait/services/api/customers_api.dart';

import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/navigation_helper.dart';

Future<void> showAddCustomerDialog(BuildContext context, WidgetRef ref) async {
  ref.watch(currentCustomerProvider.notifier).initialCustomer();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddCustomerDialog(fatherRef: ref);
    },
  );
  ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
}

class AddCustomerDialog extends ConsumerStatefulWidget {
  final WidgetRef fatherRef;
  const AddCustomerDialog({Key? key, required this.fatherRef})
      : super(key: key);
  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends ConsumerState<AddCustomerDialog> {
  int _selectedMenuIndex = 0;
  int _selectedIndex = -1;
  List<String> seatOptions = [];
  bool _isDisposed = false;
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
    _cancelToken = CancelToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        widget.fatherRef
            .read(categoryProvider.notifier)
            .fetchCategoriesFromApi(cancelToken: _cancelToken);
      }
    });
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    _isDisposed = true;
    super.dispose();
  }

  List<String> get menuOptions {
    final customer = ref.watch(currentCustomerProvider);
    final store = ref.watch(storeProvider);
    final adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );
    return adultsAndChildren
        ? [
            '大人: ${customer?.numberOfPeople ?? 0} 名',
            '小孩: ${customer?.numberOfChild ?? 0} 名',
            '座位選擇: ${seatOptions[customer?.queueType ?? 0]}',
          ]
        : [
            '人數: ${(customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0)} 名',
            '座位選擇: ${seatOptions[customer?.queueType ?? 0]}',
          ];
  }

  @override
  Widget build(BuildContext context) {
    final queueInfo = widget.fatherRef.watch(customerQueueProvider);
    final customer = widget.fatherRef.watch(currentCustomerProvider);
    final categories = widget.fatherRef
        .watch(categoryProvider)
        .categories
        .where((category) => category.hideQueue)
        .toList();
    final store = widget.fatherRef.watch(storeProvider);
    final adultsAndChildren = store.maybeWhen(
      data: (data) => data.adultsAndChildren == 'Y',
      orElse: () => false,
    );

    seatOptions = categories.map((category) => category.queueTypeName).toList();

    List<int> enabledIndices = [];
    for (int i = 0; i < categories.length; i++) {
      if (_isWithinRange(customer, categories[i], adultsAndChildren)) {
        enabledIndices.add(i);
      }
    }

    if (enabledIndices.length == 1 && _selectedIndex == -1) {
      _selectedIndex = enabledIndices.first;
      Future.microtask(() {
        ref.read(currentCustomerProvider.notifier).setCustomer(customer!
            .copyWith(
                queueType: _selectedIndex,
                queueTypeName: categories[_selectedIndex].queueTypeName));
        setState(() {});
      });
    } else if (_selectedIndex == -1 && enabledIndices.isNotEmpty) {
      _selectedIndex = enabledIndices.first;
      Future.microtask(() {
        ref.read(currentCustomerProvider.notifier).setCustomer(customer!
            .copyWith(
                queueType: _selectedIndex,
                queueTypeName: categories[_selectedIndex].queueTypeName));
        setState(() {});
      });
    }

    return AlertDialog(
      title: Center(child: Text('新增客戶')),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '現在等待組數 ${queueInfo.customers.length} 組',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '現在等待時間 約 ${queueInfo.averageProcessTimeInMinutes} 分',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: menuOptions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(menuOptions[index]),
                        selected: _selectedMenuIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedMenuIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildContent(categories, adultsAndChildren),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('取消'),
        ),
        ElevatedButton(
          onPressed: () {
            _showConfirmationDialog(adultsAndChildren);
          },
          child: Text('確認'),
        ),
      ],
    );
  }

  Widget _buildContent(List<Category> categories, bool adultsAndChildren) {
    if (_selectedMenuIndex == 0 ||
        (adultsAndChildren && _selectedMenuIndex == 1)) {
      return _buildNumpad(adultsAndChildren);
    } else {
      return _buildSeatSelection(categories);
    }
  }

  Widget _buildNumpad(bool adultsAndChildren) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: [
        ...List.generate(9, (index) => index + 1).map((number) {
          return ElevatedButton(
            onPressed: () {
              _updateNumber('$number', adultsAndChildren);
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              side: BorderSide(color: Colors.black),
            ),
            child: Text('$number', style: TextStyle(fontSize: 24)),
          );
        }).toList(),
        ElevatedButton(
          onPressed: () => _updateNumber('0', adultsAndChildren),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            side: BorderSide(color: Colors.black),
          ),
          child: Text('0', style: TextStyle(fontSize: 24)),
        ),
        ElevatedButton(
          onPressed: () => _clearLastNumber(adultsAndChildren),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            side: BorderSide(color: Colors.red),
          ),
          child: Text('清除', style: TextStyle(fontSize: 24, color: Colors.red)),
        ),
      ],
    );
  }

  Widget _buildSeatSelection(List<Category> categories) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories.map((category) {
        final index = categories.indexOf(category);
        return ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedIndex = index;
              ref.read(currentCustomerProvider.notifier).setCustomer(ref
                  .read(currentCustomerProvider)!
                  .copyWith(
                      queueType: index, queueTypeName: category.queueTypeName));
            });
          },
          child: Text(category.queueTypeName),
        );
      }).toList(),
    );
  }

  void _updateNumber(String number, bool adultsAndChildren) {
    _updateCustomerNumber(
      number: number,
      isAdd: true,
      adultsAndChildren: adultsAndChildren,
    );
  }

  void _clearLastNumber(bool adultsAndChildren) {
    _updateCustomerNumber(
      number: '',
      isAdd: false,
      adultsAndChildren: adultsAndChildren,
    );
  }

  void _updateCustomerNumber({
    required String number,
    required bool isAdd,
    required bool adultsAndChildren,
  }) {
    final customer = ref.read(currentCustomerProvider);
    String numberString = (adultsAndChildren && _selectedMenuIndex == 1)
        ? customer?.numberOfChild.toString() ?? "0"
        : adultsAndChildren
            ? (customer?.numberOfPeople ?? 0).toString()
            : ((customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0))
                .toString();

    if (isAdd) {
      if (numberString == "0") {
        numberString = number;
      } else if (numberString.length < 3) {
        numberString += number;
      }
    } else {
      if (numberString.length > 1) {
        numberString = numberString.substring(0, numberString.length - 1);
      } else {
        numberString = "0";
      }
    }

    final updatedCustomer = customer!.copyWith(
      numberOfPeople: (_selectedMenuIndex == 0)
          ? int.parse(numberString)
          : adultsAndChildren
              ? (customer.numberOfPeople)
              : int.parse(numberString),
      numberOfChild: (adultsAndChildren && _selectedMenuIndex == 1)
          ? int.parse(numberString)
          : adultsAndChildren
              ? customer.numberOfChild
              : 0,
    );
    ref.read(currentCustomerProvider.notifier).setCustomer(updatedCustomer);

    final categories = ref.read(categoryProvider).categories;
    List<int> enabledIndices = [];
    for (int i = 0; i < categories.length; i++) {
      if (_isWithinRange(updatedCustomer, categories[i], adultsAndChildren)) {
        enabledIndices.add(i);
      }
    }

    if (enabledIndices.length == 1) {
      _selectedIndex = enabledIndices.first;
      ref.read(currentCustomerProvider.notifier).setCustomer(
          updatedCustomer.copyWith(
              queueType: _selectedIndex,
              queueTypeName: categories[_selectedIndex].queueTypeName));
    } else if (enabledIndices.isNotEmpty) {
      _selectedIndex = enabledIndices.first;
      ref.read(currentCustomerProvider.notifier).setCustomer(
          updatedCustomer.copyWith(
              queueType: _selectedIndex,
              queueTypeName: categories[_selectedIndex].queueTypeName));
    }

    setState(() {});
  }

  void _showConfirmationDialog(bool adultsAndChildren) {
    final navigationHelper = NavigationHelper(ref, context);

    final customer = ref.read(currentCustomerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認新增客戶'),
          content: Text(adultsAndChildren
              ? '大人: ${customer?.numberOfPeople ?? 0} 名\n小孩: ${customer?.numberOfChild ?? 0} 名\n座位: ${customer?.queueTypeName ?? '未知'}'
              : '人數: ${(customer?.numberOfPeople ?? 0) + (customer?.numberOfChild ?? 0)} 名\n座位: ${customer?.queueTypeName ?? '未知'}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('取消'),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                final response = await addCustomer(customer!);

                Navigator.pop(context);

                if (response.isSuccess) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  navigationHelper.showErrorDialog(context, response.message);
                }
              },
              child: Text('確認'),
            ),
          ],
        );
      },
    );
  }

// 將API調用邏輯提取到單獨的方法中
  Future<void> _handleApiCall() async {
    final navigationHelper = NavigationHelper(ref, context);
    final customer = ref.read(currentCustomerProvider);
    // 顯示加載對話框
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // 調用 API
    final response = await addCustomer(customer!);

    // 隱藏加載對話框
    Navigator.pop(context);

    if (response.success) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      navigationHelper.showErrorDialog(context, response.message);
    }
  }

  bool _isWithinRange(
      Customer? customer, Category category, bool adultsAndChildren) {
    if (customer == null) return false;
    final numberOfPeople = (customer.numberOfPeople ?? 0) +
        (adultsAndChildren ? (customer.numberOfChild ?? 0) : 0);
    return numberOfPeople >= category.queuePeopleMin &&
        (category.queuePeopleMax == 0 ||
            numberOfPeople <= category.queuePeopleMax) &&
        category.hideQueue;
  }
}
