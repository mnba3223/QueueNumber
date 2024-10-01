import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/navigation_helper.dart';

class NumberInputWidget extends ConsumerStatefulWidget {
  final String title;
  final String unit;
  final int initialNumber;
  final Function(int) onChanged;
  final VoidCallback onNext;
  final bool ischildrenPage;
  NumberInputWidget({
    required this.title,
    required this.unit,
    required this.initialNumber,
    required this.onChanged,
    required this.onNext,
    this.ischildrenPage = false,
  });

  @override
  ConsumerState<NumberInputWidget> createState() => _NumberInputWidgetState();
}

class _NumberInputWidgetState extends ConsumerState<NumberInputWidget> {
  late String numberString;

  @override
  void initState() {
    super.initState();
    numberString = widget.initialNumber.toString();
  }

  void _updateNumber(String number) {
    final bool childrenCheck =
        ref.read(storeProvider).value?.adultsAndChildren == "Y";

    if (childrenCheck
        ? (numberString == "0" && number != "0")
        : (numberString == "1" && number != "1" && number != "0")) {
      numberString = number;
    } else if (numberString.length < 3) {
      numberString += number;
    }
    setState(() {});
    widget.onChanged(int.parse(numberString));
  }

  void _clearLastNumber() {
    final bool childrenCheck =
        ref.read(storeProvider).value?.adultsAndChildren == "Y";
    if (numberString.length > 1) {
      numberString = numberString.substring(0, numberString.length - 1);
    } else {
      childrenCheck ? numberString = "0" : numberString = "1";
    }
    setState(() {});
    widget.onChanged(int.parse(numberString));
  }

  @override
  Widget build(BuildContext context) {
    final navigationHelper = NavigationHelper(ref, context);
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        onBackPressed: navigationHelper.navigateToPreviousPage,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: LayoutBuilder(builder: (context, constraints) {
                      double inputWidth = (constraints.maxWidth) / 3; // 計算按鈕大小
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: inputWidth,
                            height: inputWidth / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              numberString,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text('  ${widget.unit}',
                                  style: TextStyle(fontSize: 24))),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: LayoutBuilder(builder: (context, constraints) {
                      double buttonSize =
                          (constraints.maxWidth - 4 * 16) / 5.5; // 計算按鈕大小
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNumberButton(
                                  '1', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '2', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '3', _updateNumber, buttonSize),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNumberButton(
                                  '4', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '5', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '6', _updateNumber, buttonSize),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNumberButton(
                                  '7', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '8', _updateNumber, buttonSize),
                              _buildNumberButton(
                                  '9', _updateNumber, buttonSize),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildNumberButton(
                                  '0', _updateNumber, buttonSize),
                              _buildClearButton(_clearLastNumber, buttonSize),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: widget.onNext,
                child: Text(
                  "下一步",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: AppColors.White,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(
      String number, Function(String) onPressed, double buttonSize) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onPressed(number),
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Ink(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange),
            ),
            child: Center(
              child: Text(
                number,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton(Function onPressed, double buttonSize) {
    return Container(
      width: buttonSize * 2.1,
      height: buttonSize,
      child: GestureDetector(
        onTap: () => onPressed(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(buttonSize),
          ),
          alignment: Alignment.center,
          child: Text(
            '清除',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onBackPressed;

  CustomAppBar({required this.title, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).appBarTheme.color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: AppColors.primaryColor,
                      onPressed: () => onBackPressed(),
                    ),
                    Text(
                      "取消",
                      style: TextStyle(
                          fontSize: 6.8.sp, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: AppColors.primaryColor),
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
