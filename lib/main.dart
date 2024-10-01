import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/services/api_service.dart';
import 'package:qswait/services/app_router.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/app_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [
          Locale('zh', 'TW'),
          Locale('en', 'US'),
          Locale('ja', 'JP')
        ],
        path:
            'assets/langs/langs.csv', // directory that contains langauge files
        fallbackLocale: Locale('en', 'US'),
        startLocale: Locale('zh', 'TW'),
        assetLoader: CsvAssetLoader(), // use csv asset loader
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
// class MyApp extends StatelessWidget {

  @override
  void initState() {
    super.initState();
    // _checkToken(ref);
  }

  // This widget is the root of your application.
  final appRouter = AppRouter();
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp.router(
      // routerConfig: appRouter.config(),
      routerConfig: getIt<AppRouter>().config(),
      title: 'Flutter Demo',
      // routerDelegate:
      // appRouter.delegate(reevaluateListenable: authProvider),
      // theme: MaterialTheme(TextTheme()).light(),
      // darkTheme: MaterialTheme(TextTheme()).dark(),
      // highContrastDarkTheme: MaterialTheme(TextTheme()).darkHighContrast(),
      // highContrastTheme: MaterialTheme(TextTheme()).lightHighContrast(),

      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // routerDelegate: appRouter.delegate(
      //   navigatorObservers: () => [
      //     MyRouteObserver(),
      //   ],
      // ),
      // routeInformationParser: appRouter.defaultRouteParser(),
      theme: AppTheme.themeData,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // Responsive setting
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Future<void> _checkToken(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final response = await apiService.verifyToken(token);
      if (response['success']) {
        log("login by token");
        final storeData = response['store'];

        // 將 store 資料保存到 storeProvider 中
        final storeNotifier = ref.read(storeProvider.notifier);
        storeNotifier.updateStore(Store.fromJson(storeData));
        // 存儲 storeId
        final storeId = storeData['storeId'];

        await prefs.setString('storeId', storeId);

        getIt<AppRouter>()
            .replaceNamed('/customer'); // 使用 get_it 獲取 AppRouter 並導航
        ref.read(refreshProvider.notifier).start(ref);
      } else {
        print("remove token");
        prefs.remove('token'); // 移除無效的 token
        getIt<AppRouter>().replaceNamed('/login'); // 使用 get_it 獲取 AppRouter 並導航
      }
    } else {
      getIt<AppRouter>().replaceNamed('/login'); // 使用 get_it 獲取 AppRouter 並導航
    }
  }
}

// @RoutePage()
// class MyHomePage extends ConsumerWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = AutoRouter.of(context);
//     final selectedIndex = ref.watch(selectedIndexProvider);

//     List<Widget> pages = [Customer_main_page(), Cusy()];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Riverpod Example"),
//       ),
//       body: Center(
//         child: pages[selectedIndex], // Display the selected page
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.language),
//             label: 'Language',
//           ),
//         ],
//         currentIndex: selectedIndex,
//         onTap: (index) =>
//             ref.read(selectedIndexProvider.notifier).state = index,
//       ),
//     );
//   }
// }
// class MyRouteObserver extends AutoRouterObserver {
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     _checkForNewCustomerNotifications();
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _checkForNewCustomerNotifications();
//   }

//   void _checkForNewCustomerNotifications() {
//     final context = getIt<AppRouter>().navigatorKey.currentState?.context;
//     final currentRouteName = context?.router.current.name;
//     final isRelevantPage = currentRouteName == 'AdminRoute' ||
//         currentRouteName == 'MerchantMultipleMainRoute';

//     if (isRelevantPage) {
//       final unnotifiedCustomerIds = ref.read(customerQueueProvider.notifier).unnotifiedCustomerIds;
//       if (unnotifiedCustomerIds != null && unnotifiedCustomerIds.isNotEmpty) {
//         showDialog(
//           context: context!,
//           builder: (context) => AlertDialog(
//             title: Text('新客戶通知'),
//             content: Text('有新的客戶加入了隊列。'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   ref.read(customerQueueProvider.notifier).clearNewCustomerNotifications();
//                 },
//                 child: Text('確定'),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   }
// }