import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/state/queueStatus.dart';
import 'package:qswait/pages/marchant/function/function.dart';
import 'package:qswait/pages/marchant/widget/merchant_right_block.dart';
import 'package:qswait/pages/marchant/widget/slider_status.dart';
import 'package:qswait/services/api/customers_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/time.dart';

@RoutePage()
class MerchantMainPage extends ConsumerStatefulWidget {
  const MerchantMainPage({super.key});

  @override
  ConsumerState<MerchantMainPage> createState() => _MerchantMainPageState();
}

class _MerchantMainPageState extends ConsumerState<MerchantMainPage> {
  String dropdownValue = 'All';
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
        fetchCustomersFromApi(ref, storeId!, cancelToken: cancelToken);
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customerPageNotifier = ref.watch(customerPageProvider.notifier);
    final queueInfo = ref.watch(customerQueueProvider);
    final categories = ref.watch(categoryProvider).categories;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['All']
              .followedBy(categories.map((category) => category.queueTypeName))
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            context.router.removeLast();
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 247, 247, 247),
        child: Row(
          children: [
            Expanded(flex: 2, child: LeftBlockPage2(ref, dropdownValue)),
            // Expanded(
            //     flex: 1, child: RightBlockPage(customerPageNotifier, queueInfo,))
          ],
        ),
      ),
    );
  }
}

class LeftBlockPage2 extends ConsumerStatefulWidget {
  final WidgetRef passedRef;
  final String queueTypeFilter;
  const LeftBlockPage2(this.passedRef, this.queueTypeFilter, {super.key});
  @override
  ConsumerState<LeftBlockPage2> createState() => _LeftBlockPage2State();
}

class _LeftBlockPage2State extends ConsumerState<LeftBlockPage2> {
  List<Customer> _filteredRows = [];
  int? _expandedIndex;
  bool expandAll = false;
  QueueStatus selectedSegment = QueueStatus.Waiting;
  String selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    filterRows(selectedSegment, widget.queueTypeFilter, selectedStatus);
  }

  void filterRows(
      QueueStatus status, String queueTypeFilter, String callStatus) {
    final queueInfo = widget.passedRef.watch(customerQueueProvider);
    setState(() {
      _filteredRows = queueInfo.customers.where((customer) {
        bool matchesStatus = customer.queueStatus == status.toShortString();
        bool matchesQueueType = queueTypeFilter == 'All' ||
            customer.queueTypeName == queueTypeFilter;
        bool matchesCallStatus = callStatus == 'All' ||
            (callStatus == '未叫號' && customer.callingStatus == 'notCalled') ||
            (callStatus == '叫號中' && customer.callingStatus == 'calling') ||
            (callStatus == '已叫號' && customer.callingStatus == 'called');
        return matchesStatus && matchesQueueType && matchesCallStatus;
      }).toList()
        ..sort((a, b) => a.currentSort!.compareTo(b.currentSort!));
    });
  }

  @override
  Widget build(BuildContext context) {
    filterRows(selectedSegment, widget.queueTypeFilter, selectedStatus);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SegmentedButton<QueueStatus>(
            segments: [
              ButtonSegment(
                value: QueueStatus.Waiting,
                label: Text('Waiting'),
              ),
              ButtonSegment(
                value: QueueStatus.Processing,
                label: Text('Seating'),
              ),
              ButtonSegment(
                value: QueueStatus.Cancelled,
                label: Text('Canceled'),
              ),
            ],
            onSelectionChanged: (newSelection) {
              setState(() {
                selectedSegment = newSelection.first;
                filterRows(
                    selectedSegment, widget.queueTypeFilter, selectedStatus);
              });
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
            selected: {selectedSegment},
          ),
          SizedBox(height: 16),
          Divider(),
          Center(
              child:
                  Text('呼叫狀態', style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(height: 8),
          Center(
            child: DropdownButton<String>(
              value: selectedStatus,
              icon: Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                  filterRows(
                      selectedSegment, widget.queueTypeFilter, selectedStatus);
                });
              },
              items: <String>['All', '未叫號', '叫號中', '已叫號']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Text('號碼')),
                    Expanded(child: Text('時間')),
                    Expanded(child: Text('人數')),
                    Expanded(child: Text('席位')),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(expandAll
                              ? Icons.expand_less
                              : Icons.expand_more),
                          onPressed: () {
                            setState(() {
                              expandAll = !expandAll;
                              _expandedIndex = expandAll ? null : -1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final item = _filteredRows.removeAt(oldIndex);
                  _filteredRows.insert(newIndex, item);
                });
              },
              children: _filteredRows
                  .map((customer) => buildCustomerRow(
                        customer,
                        context,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomerRow(Customer customer, BuildContext context) {
    return Column(
      key: ValueKey(customer.currentSort),
      children: [
        Slidable(
          endActionPane: ActionPane(
            extentRatio: getQueueStatusNumber(selectedSegment),
            motion: const ScrollMotion(),
            children: generateSlidableActions(
                selectedSegment, context, customer, widget.passedRef),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 16,
                ),
                child: Row(children: [
                  Expanded(child: Text(customer.queueNum.toString())),
                  Expanded(
                      child: Text(convertTimeTo24HourFormat(customer.time))),
                  Expanded(child: Text(customer.numberOfPeople.toString())),
                  Expanded(child: Text(customer.queueTypeName)),
                  // Expanded(child: buildCallingStatus(customer, context)),
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
