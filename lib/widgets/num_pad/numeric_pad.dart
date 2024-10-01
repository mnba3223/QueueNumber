import 'dart:developer';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qswait/services/api/admin_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';

class NumericPad extends StatefulWidget {
  final Function(String) onNumberSelected;

  const NumericPad({Key? key, required this.onNumberSelected})
      : super(key: key);

  @override
  _NumericPadState createState() => _NumericPadState();
}

class _NumericPadState extends State<NumericPad> {
  String enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonSize = (constraints.maxWidth - 4 * 16) / 5; // 計算按鈕大小

        Widget _buildNumberButton(String number) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleNumberPress(number),
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

        Widget _buildClearButton() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _clearLastNumber,
                borderRadius: BorderRadius.circular(buttonSize / 2),
                child: Ink(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.backspace, size: 24, color: Colors.orange),
                      Text(
                        '清除',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('0'),
                  _buildClearButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleNumberPress(String number) {
    setState(() {
      if (enteredPassword.length < 4) {
        enteredPassword += number;
        if (enteredPassword.length == 4) {
          widget.onNumberSelected(enteredPassword);
        }
      }
    });
  }

  void _clearLastNumber() {
    setState(() {
      if (enteredPassword.isNotEmpty) {
        enteredPassword =
            enteredPassword.substring(0, enteredPassword.length - 1);
      }
    });
  }
}

///顯示數字盤，輸入後台密碼操作
void showNumericPadDialog(
    BuildContext context, PageRouteInfo<dynamic> nextPageRoute,
    {String storeId = ""}) {
  // log("storeid ${storeId}");
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          // color: Colors.amber,
          margin: EdgeInsets.all(1.5.sp),
          child: IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    '請輸入密碼',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.CommonText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.white,
          child: Container(
            // padding: EdgeInsets.all(5.0),
            child: NumericPadVersion2(
              onNumberSelected: (enteredPassword) {
                // Navigator.of(context).pop();
                validatePassword(
                    enteredPassword, context, nextPageRoute, storeId);
              },
            ),
          ),
        ),
      );
    },
  );
}

// void validatePassword(String password, BuildContext context,
//     PageRouteInfo<dynamic> nextPageRoute) {
//   if (password == '1234') {
//     // 密码正确，导航到指定页面
//     AutoRouter.of(context).replace(nextPageRoute);
//   } else {
//     // 密码错误，显示错误提示
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('错误'),
//         content: Text('密码错误，请重试！'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // 关闭错误提示对话框
//               //  validatePassword( context, nextPageRoute);
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
// }

void validatePassword(String password, BuildContext context,
    PageRouteInfo<dynamic> nextPageRoute, String storeId) async {
  // BuildContext _dialogContext;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // _dialogContext = dialogContext;
        return Center(
          child: CircularProgressIndicator(),
        );
      });

  try {
    final response = await validateBackendPassword(storeId, password);

    // if (!context.mounted) return;
    Navigator.of(context).pop(); // 關閉進度提示框

    if (response.success) {
      // 密碼正確，導航到指定頁面
      AutoRouter.of(context).replace(nextPageRoute);
    } else {
      Navigator.of(context).pop(); // 關閉進度提示框
      // 密碼錯誤，顯示錯誤提示
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('錯誤'),
          content: Text('密碼錯誤，請重試！'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 關閉錯誤提示對話框
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    Navigator.of(context).pop(); // 關閉進度提示框

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('錯誤'),
        content: Text('驗證失敗，請稍後重試！'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 關閉錯誤提示對話框
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

void showConfirmPasswordDialog(
    BuildContext context, String storeId, String newPassword) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.all(1.5.sp),
          child: IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    '請再次輸入新密碼',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.CommonText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.white,
          padding: EdgeInsets.all(30.0),
          child: NumericPadVersion2(
            onNumberSelected: (confirmedPassword) async {
              if (confirmedPassword == newPassword) {
                showLoadingDialog(context); // 显示加载指示器
                final response =
                    await editBackendPassword(storeId, newPassword);
                Navigator.of(context).pop(); // 关闭加载指示器
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(response.success
                        ? '密碼更新成功'
                        : '密碼更新失敗: ${response.message}'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('兩次輸入的密碼不相同，請重試！'),
                  ),
                );
              }
              Navigator.of(context).pop(); // 关闭确认密码对话框
            },
          ),
        ),
      );
    },
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void showNewPasswordDialog(BuildContext context, String storeId) {
  showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.all(1.5.sp),
          child: IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    '請輸入新密碼',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.CommonText,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        content: Container(
          width: MediaQuery.of(context).size.height * 0.5,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
          child: NumericPadVersion2(
            onNumberSelected: (enteredPassword) {
              Navigator.of(context).pop();
              showConfirmPasswordDialog(context, storeId, enteredPassword);
            },
          ),
        ),
      );
    },
  );
}

class NumericPad2 extends StatefulWidget {
  final void Function(String enteredPassword) onNumberSelected;

  const NumericPad2({Key? key, required this.onNumberSelected})
      : super(key: key);

  @override
  State<NumericPad2> createState() => _NumericPad2State();
}

class _NumericPad2State extends State<NumericPad2> {
  String enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          enteredPassword,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        GridView.builder(
          itemCount: 12,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            if (index == 9) return Container(); // Placeholder for layout
            String buttonText = index == 10
                ? '0'
                : index == 11
                    ? '清除'
                    : '${index + 1}';
            return ElevatedButton(
              onPressed: () => _handleKeyPress(buttonText),
              child: Text(buttonText, style: TextStyle(fontSize: 20)),
            );
          },
        ),
      ],
    );
  }

  void _handleKeyPress(String key) {
    setState(() {
      if (key == '清除') {
        if (enteredPassword.isNotEmpty) {
          enteredPassword =
              enteredPassword.substring(0, enteredPassword.length - 1);
        }
      } else {
        if (enteredPassword.length < 4) {
          enteredPassword += key;
          if (enteredPassword.length == 4) {
            widget.onNumberSelected(enteredPassword);
          }
        }
      }
    });
  }
}

class NumericPad3 extends StatefulWidget {
  final Function(String) onNumberPress;
  final Function() onClearLast;

  const NumericPad3({
    Key? key,
    required this.onNumberPress,
    required this.onClearLast,
  }) : super(key: key);

  @override
  _NumericPad3State createState() => _NumericPad3State();
}

class _NumericPad3State extends State<NumericPad3> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonSize = (constraints.maxHeight - 4 * 16) / 5; // 計算按鈕大小

        Widget _buildNumberButton(String number) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onNumberPress(number),
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
            ),
          );
        }

        Widget _buildClearButton() {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onClearLast,
                borderRadius: BorderRadius.circular(buttonSize / 2),
                child: Ink(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.backspace, size: 24, color: Colors.orange),
                      Text(
                        '清除',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('1'),
                  _buildNumberButton('2'),
                  _buildNumberButton('3'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('4'),
                  _buildNumberButton('5'),
                  _buildNumberButton('6'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('7'),
                  _buildNumberButton('8'),
                  _buildNumberButton('9'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton('0'),
                  _buildClearButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // void _handleNumberPress(String number) {
  //   setState(() {
  //     if (enteredNumber == "0") {
  //       enteredNumber = number;
  //     } else if (enteredNumber.length < 3) {
  //       enteredNumber += number;
  //     }
  //     widget.onNumberSelected(enteredNumber);
  //   });
  // }

  // void _clearLastNumber() {
  //   setState(() {
  //     if (enteredNumber.length > 1) {
  //       enteredNumber = enteredNumber.substring(0, enteredNumber.length - 1);
  //     } else {
  //       enteredNumber = "0";
  //     }
  //     widget.onClearLastNumber();
  //     widget.onNumberSelected(enteredNumber); // 更新顯示
  //   });
  // }
}

class NumericPadVersion2 extends StatefulWidget {
  final Function(String) onNumberSelected;

  const NumericPadVersion2({Key? key, required this.onNumberSelected})
      : super(key: key);

  @override
  _NumericPadVersion2State createState() => _NumericPadVersion2State();
}

class _NumericPadVersion2State extends State<NumericPadVersion2> {
  String enteredPassword = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double buttonSize = (constraints.maxWidth - 4 * 16) / 4; // 計算按鈕大小
      Widget _buildNumberButton(String number) {
        return Padding(
          padding: EdgeInsets.all(2.sp),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleNumberPress(number),
              borderRadius: BorderRadius.circular(buttonSize / 2),
              child: Ink(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor),
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

      Widget _buildClearButton() {
        return Padding(
          padding: EdgeInsets.all(2.sp),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _clearLastNumber,
              borderRadius: BorderRadius.circular(buttonSize / 2),
              child: Ink(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Center(
                  child: Text(
                    '清除',
                    style:
                        TextStyle(fontSize: 18, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 1.0.dg),
              margin: EdgeInsets.only(bottom: 5.sp, left: 6.sp, right: 6.sp),
              decoration: BoxDecoration(
                color: AppColors.neutral94,
                borderRadius: BorderRadius.circular(10.0),
              ),
              // height: 50, // 这里可以根据需要调整高度
              child: Text(
                '*' * enteredPassword.length,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.CommonText,
                    letterSpacing: 4.sp),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('0'),
                // _buildClearButton(),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.transparent,
                    side: BorderSide(color: AppColors.primaryColor), // 橘色外框線
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 圓框
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.5.sp, horizontal: 13.sp), // 內部填充
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _clearLastNumber();
                  },
                  child: Text(
                    '清除',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.transparent,
                    side: BorderSide(color: AppColors.primaryColor), // 橘色外框線
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 圓框
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 3.sp, horizontal: 13.sp), // 內部填充
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void _handleNumberPress(String number) {
    setState(() {
      if (enteredPassword.length < 4) {
        enteredPassword += number;
        if (enteredPassword.length == 4) {
          widget.onNumberSelected(enteredPassword);
        }
      }
    });
  }

  void _clearLastNumber() {
    setState(() {
      if (enteredPassword.isNotEmpty) {
        enteredPassword =
            enteredPassword.substring(0, enteredPassword.length - 1);
      }
    });
  }
}
