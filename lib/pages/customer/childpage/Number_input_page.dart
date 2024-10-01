import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/pages/customer/widgets/NumberPad.dart';

import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/navigation_helper.dart';

// @RoutePage()

// // ///數字輸入頁面
// class NumberInputPage extends ConsumerStatefulWidget {
//   const NumberInputPage({super.key});

//   @override
//   ConsumerState<NumberInputPage> createState() => _NumberInputPageState();
// }

// class _NumberInputPageState extends ConsumerState<NumberInputPage> {
//   @override
//   Widget build(BuildContext context) {
//     final customer = ref.watch(currentCustomerProvider);
//     final navigationHelper = NavigationHelper(ref, context);
//     // final apiService = ref.watch(apiServiceProvider);
//     // String numberString = customer?.numberOfPeople.toString() ?? "1";
//     String numberString = "1";

//     void _updateNumber(String number) {
//       print("numberString: $numberString, number: $number");
//       if (numberString == "1" && number != "0") {
//         numberString = number;
//       } else if (numberString.length < 3) {
//         // Limiting to 3 digits for example
//         numberString += number;
//       }
//       ref.read(currentCustomerProvider.notifier).setCustomer(
//           customer!.copyWith(numberOfPeople: int.parse(numberString)));
//     }

//     void _clearLastNumber() {
//       if (numberString.length > 1) {
//         ref.read(currentCustomerProvider.notifier).setCustomer(customer!
//             .copyWith(
//                 numberOfPeople: int.parse(
//                     numberString.substring(0, numberString.length - 1))));
//       } else {
//         ref
//             .read(currentCustomerProvider.notifier)
//             .setCustomer(customer!.copyWith(numberOfPeople: 1));
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('输入人数'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: navigationHelper.navigateToPreviousPage,
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: IntrinsicHeight(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           width: 200,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           child: Text(
//                             numberString,
//                             style: TextStyle(
//                               fontSize: 50,
//                             ),
//                           ),
//                         ),
//                         Text(' 人', style: TextStyle(fontSize: 24)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                       width:
//                           20), // Spacing between the text field and the number pad
//                   Expanded(
//                     child: Container(
//                       padding:
//                           const EdgeInsets.only(top: 50, left: 100, right: 100),
//                       child: GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           childAspectRatio:
//                               2, // Adjust based on your preference
//                         ),
//                         itemCount: 12,
//                         itemBuilder: (context, index) {
//                           // Adjust the number pad size by wrapping it with a Container
//                           return Container(
//                             margin: EdgeInsets.all(8),
//                             child: index == 9
//                                 ? Container() // Leave an empty space
//                                 : (index == 10
//                                     ? _buildNumberButton('0', _updateNumber)
//                                     : (index == 11
//                                         ? _buildClearButton(_clearLastNumber)
//                                         : _buildNumberButton(
//                                             '${index + 1}', _updateNumber))),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           /// To Next Button
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: ElevatedButton(
//               onPressed: () async {
//                 /// save person number
//                 ref.read(currentCustomerProvider.notifier).setCustomer(customer!
//                     .copyWith(numberOfPeople: int.tryParse(numberString)));
//                 print(customer);

//                 /// to next page
//                 navigationHelper.navigateToNextPage();
//                 // AutoRouter.of(context).push(NumberInputPage());
//               },
//               child: Text('下一步', style: TextStyle(fontSize: 24)),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNumberButton(String number, Function(String) onPressed) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         // primary: Colors.grey[200], // Background color for button
//         // onPrimary: Colors.black, // Text color for button
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(
//         number,
//         style: TextStyle(fontSize: 24),
//       ),
//       onPressed: () => onPressed(number),
//     );
//   }

//   Widget _buildClearButton(Function onPressed) {
//     return GestureDetector(
//       onTap: () => onPressed(),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.red),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         alignment: Alignment.center,
//         child: Text('清除',
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
//       ),
//     );
//   }
// }

@RoutePage()
class NumberInputPage extends ConsumerStatefulWidget {
  const NumberInputPage({super.key});

  @override
  ConsumerState<NumberInputPage> createState() => _NumberInputPageState();
}

class _NumberInputPageState extends ConsumerState<NumberInputPage> {
  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(currentCustomerProvider);
    final navigationHelper = NavigationHelper(ref, context);
    final store = ref.watch(storeProvider);
    AsyncValue<bool> showAdultsAndChildren =
        store.whenData((data) => data.adultsAndChildren == 'Y');

    ///切換
    ///
    //   return NumberInputWidget(
    //     title: '輸入成人人數',
    //     unit: '人',
    //     initialNumber: customer?.numberOfPeople ?? 1,
    //     onChanged: (number) {
    //       ref.read(currentCustomerProvider.notifier).setCustomer(
    //             customer!.copyWith(numberOfPeople: number),
    //           );
    //     },
    //     onNext: () {
    //       navigationHelper.navigateToNextPage();
    //     },
    //   );
    // }
    return showAdultsAndChildren.when(
      data: (show) {
        return NumberInputWidget(
          title: show ? '輸入成人人數' : '輸入人數',
          unit: '位',
          initialNumber: customer?.numberOfPeople ?? 1,
          onChanged: (number) {
            ref.read(currentCustomerProvider.notifier).setCustomer(
                  customer!.copyWith(numberOfPeople: number),
                );
          },
          onNext: () {
            navigationHelper.navigateToNextPage(
                needCheckNumber: show ? false : true);
          },
        );
      },
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
