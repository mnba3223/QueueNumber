import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qswait/main.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/app_router.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  Store mockStore = Store(
    id: 1,
    storeId: "STORE001",
    storeName: "咖啡天地",
    contactUser: "張經理",
    contactEmail: "manager@coffeeheaven.com",
    contactPhone: "0912345678",
    storeAdd: "台北市中正區忠孝東路100號",
    openingTime: "09:00",
    resetQueueNumberTime: "00:00",
    webGetNumber: "Y",
    numberOfPeople: "Y",
    useNotepad: "Y",
    adultsAndChildren: "N",
    autoTakeNumber: "Y",
    extendedMode: "N",
    cuttingInLine: "N",
    stopTakingNumbers: "N",
    frontEndClosed: "N",
    notifyTheReceptionist: "Y",
    notifyCustomerCancellation: "Y",
    receptionSound: "default",
    screenSaver: "Y",
    queueResetTime: "23:59",
    skipConfirmationScreen: "N",
    showWaitingAlerts: "Y",
    queueTimeSettingAll: "30",
    showGroupsOrPeople: "groups",
    useNoCallToCalculate: "N",
    highlightOverTime: 15,
    queueTimeSettingAllWaitingTime: 20,
    queueTimeSettingAllIntervalTime: 5,
    allWaitingTimeDisplayed: "total",
    businessHoursTime: "09:00-21:00",
    showWaitingTime: "Y",
  );

  /// this is api usage
  // final String assetName = 'assets/images/logo/Logo2.svg';
  // Future<void> _login() async {
  //   setState(() {
  //     _isLoading = true;
  //     _errorMessage = null;
  //   });

  //   final username = _usernameController.text;
  //   final password = _passwordController.text;

  //   try {
  //     final response = await apiService.login(username, password);

  //     if (response.containsKey('token') && response['success']) {
  //       final token = response['token'];
  //       // final storeData = response['data'];

  //       // 將 store 資料保存到 storeProvider 中
  //       final storeNotifier = ref.read(storeProvider.notifier);
  //       // storeNotifier.updateStore(Store.fromJson(storeData));
  //       storeNotifier.updateStore(mockStore);
  //       // print('登入成功，token: $token');
  //       ref.read(refreshProvider.notifier).start(ref);

  //       final prefs = await SharedPreferences.getInstance();
  //       // 存儲 storeId
  //       // final storeId = storeData['storeId'];

  //       // storeNotifier.setStoreId(storeId); // 設置 storeId 並立即調用 fetchStoreInfo
  //       // await prefs.setString('storeId', storeId);
  //       storeNotifier
  //           .setStoreId(mockStore.storeId); // 設置 storeId 並立即調用 fetchStoreInfo
  //       await prefs.setString('storeId', mockStore.storeId);

  //       ref.read(storeProvider.notifier).loadCachedStoreLogo();
  //       // storeNotifier.setID(storeId);
  //       // 存储 JWT 令牌
  //       await prefs.setString('token', token);

  //       getIt<AppRouter>().pushNamed('/customer'); // 使用 get_it 獲取 AppRouter 並導航
  //     } else {
  //       setState(() {
  //         _errorMessage = '登入失敗，請檢查帳號與密碼是否正確';
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       _errorMessage = '登入失敗，請確認是否正常連線';
  //     });
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      // 模擬網絡延遲
      await Future.delayed(Duration(seconds: 2));

      // 模擬登錄成功
      final mockResponse = {
        'success': true,
        'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      };

      if (mockResponse['success'] == true) {
        final String token = mockResponse['token'].toString();

        final storeNotifier = ref.read(storeProvider.notifier);
        storeNotifier.updateStore(mockStore);

        ref.read(refreshProvider.notifier).start(ref);

        final prefs = await SharedPreferences.getInstance();

        storeNotifier.setStoreId(mockStore.storeId);
        await prefs.setString('storeId', mockStore.storeId);

        ref.read(storeProvider.notifier).loadCachedStoreLogo();

        await prefs.setString('token', token);

        getIt<AppRouter>().pushNamed('/customer');
      } else {
        throw Exception('Mock login failed');
      }
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = '登入失敗，請確認是否正常連線';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              // Container(
              //   // color: Colors.amber,
              //   margin: EdgeInsets.only(bottom: 20.0),
              //   child: Image.asset(
              //     'assets/images/logo/Logo2.png',
              //     width: 100.0,
              //     height: 100.0,
              //   ),
              // ),
              SizedBox(height: 30.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: '會員帳號',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '密碼',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text('記住此帳號密碼'),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          '登入',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.White,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.orange,
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                      ),
                    ),
              if (_errorMessage != null) ...[
                SizedBox(height: 20.0),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ],
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  // 忘記帳號密碼按鈕邏輯
                },
                child: Text('忘記帳號密碼'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      // 使用條款按鈕邏輯
                    },
                    child: Text('使用條款'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 隱私權政策按鈕邏輯
                    },
                    child: Text('隱私權政策'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 常見問題按鈕邏輯
                    },
                    child: Text('常見問題'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
