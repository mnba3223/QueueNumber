// import 'package:auto_route/auto_route.dart';
// import 'package:data_table_2/data_table_2.dart';
// import 'package:easy_localization/easy_localization.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:qswait/models/customer/Customer_class.dart';
// import 'package:qswait/pages/customer/api/api.dart';
// import 'package:qswait/services/api/customers_api.dart';

// import 'package:qswait/services/app_router.gr.dart';
// import 'package:qswait/services/riverpod_state_management.dart';
// import 'package:qswait/widgets/card_ui.dart';
// import 'package:qswait/widgets/num_pad/numeric_pad.dart';

// import 'package:responsive_framework/responsive_framework.dart';

// @RoutePage()
// class customer_page1 extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<customer_page1> createState() => _customer_page1State();
// }

// class _customer_page1State extends ConsumerState<customer_page1> {
// //   // String inputText = '';

//   // 获取页面控制器的状态通知器

//   @override
//   Widget build(BuildContext context) {
//     final apiService = ref.watch(apiServiceProvider);
//     final customerPageNotifier = ref.watch(customerPageProvider.notifier);

//     fetchCustomersFromApi(ref, apiService);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(80.0),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             title: Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Row(children: [
//                 Icon(Icons.abc_sharp, size: 100),
//                 // Text('Wine Cellar'),
//               ]),
//             ),
//           ),
//         ),
//         body: ResponsiveBreakpoints.of(context).isTablet ||
//                 ResponsiveBreakpoints.of(context).largerThan(TABLET)
//             ? TabletLayout()
//             : MobileLayout(),

//         /// button in the lower right corner
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             // showNumericPadDialog(context, MainMenuRoute());
//             // AutoRouter.of(context).push(MainMenuRoute());
//             AutoRouter.of(context).push(AdminRoute());
//           },
//           child: Icon(Icons.settings, color: Colors.black54),
//           backgroundColor: Colors.transparent, // No background color on tap
//           // focusColor: Colors.transparent,
//           splashColor: Colors.transparent, // No splash color on tap
//           // hoverColor: Colors.transparent, // No highlight color on tap
//           highlightElevation: 0,
//           // focusElevation: 0,
//           // hoverElevation: 0,
//           // foregroundColor: Colors.transparent,
//           // tooltip: '',
//           elevation: 0, //remove the shadow
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       ),
//     );
//   }
// }

// class TabletLayout extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<TabletLayout> createState() => _TabletLayoutState();
// }

// class _TabletLayoutState extends ConsumerState<TabletLayout> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final customerPageNotifier = ref.read(customerPageProvider.notifier);
//     final queueInfo = ref.watch(customerQueueProvider);
//     List<Customer> waitingCustomers = queueInfo.customers
//         .where((customer) => customer.queueStatus == 'waiting')
//         .toList();
//     // 按照 `currentSort` 屬性排序
//     waitingCustomers.sort((a, b) => a.currentSort!.compareTo(b.currentSort!));
//     void navigateToNextPage() {
//       print(
//           "customerPageNotifier.getCurrentPage(): ${customerPageNotifier.getCurrentPage()}");
//       if (customerPageNotifier.hasNextPage()) {
//         customerPageNotifier.toNextPage();
//         context.router.pushNamed(customerPageNotifier.getCurrentPage());
//       } else {
//         // if list is complete, navigate to final check
//         context.router.push(FinalCheck());
//       }
//     }
//     // final queue = ref.watch(queueProvider);

//     // You can further adjust the padding and margins as needed
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Center(
//                   child: Container(
//                     padding: EdgeInsets.only(bottom: 10),
//                     child: Text(
//                       '目前等待的顧客',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30.0, vertical: 10.0),
//                     child: DataTable2(
//                       // columnSpacing: 10.0,
//                       // minWidth: 600,
//                       headingRowHeight: 56,
//                       dataRowHeight: 48,
//                       headingRowColor: MaterialStateProperty.resolveWith(
//                         (states) => Colors.grey[200]!,
//                       ),
//                       columns: const <DataColumn>[
//                         DataColumn(label: Text('處理的號碼')),
//                         DataColumn(label: Text('總人數')),
//                         DataColumn(label: Text('席位')),
//                       ],
//                       rows: waitingCustomers
//                           .map<DataRow>((customer) => DataRow(
//                                 cells: <DataCell>[
//                                   DataCell(Text(customer.id.toString())),
//                                   DataCell(
//                                       Text(customer.numberOfPeople.toString())),
//                                   DataCell(Text(
//                                       _checkinTypeToString(customer.queueType))),
//                                 ],
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 24),
//           Expanded(
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           // padding: EdgeInsets.symmetric(vertical: 40),
//                           height: MediaQuery.of(context).size.height * 0.2,
//                           width: MediaQuery.of(context).size.width * 0.13,
//                           child: CustomInformationCard(
//                             icon: Icons.people,
//                             title: '等待组数:',
//                             value: ' ${waitingCustomers.length} 組',
//                           ),
//                         ),
//                         SizedBox(
//                             width:
//                                 16), // Change to SizedBox for horizontal space
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.2,
//                           width: MediaQuery.of(context).size.width * 0.13,
//                           // height: MediaQuery.of(context).size.height * 0.2,
//                           child: CustomInformationCard(
//                             icon: Icons.timer,
//                             title: '等待時間',
//                             value: '約${waitingCustomers.length * 5}分',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32),

//                 ///進入下一頁按鈕
//                 Container(
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height * 0.25,
//                   padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width * 0.05),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       /// to next page
//                       ref
//                           .read(currentCustomerProvider.notifier)
//                           .initialCustomer();

//                       navigateToNextPage();
//                       // AutoRouter.of(context)
//                       //     .push(NumberInputRoute()); // NextStepRoute 是下一步的路由
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '首先請點擊這裡 ',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20, // Set your desired font size here
//                           ),
//                         ),
//                         Text(
//                           '按順序進入',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 50, // Set your desired font size here
//                           ),
//                         ),
//                       ],
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Background color
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   String _checkinTypeToString(int? type) {
//     switch (type) {
//       case 0:
//         return '一般席';
//       case 1:
//         return 'VIP席';
//       case 2:
//         return '單獨席';
//       default:
//         return '未知';
//     }
//   }
// }

// ///橫版卡片
// class InformationCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;

//   const InformationCard({
//     required this.icon,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Icon(icon, size: 48),
//             SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MobileLayout extends StatelessWidget {
//   // Placeholder for mobile layout
//   @override
//   Widget build(BuildContext context) {
//     return Container(); // You can define MobileLayout in a similar fashion.
//   }
// }
