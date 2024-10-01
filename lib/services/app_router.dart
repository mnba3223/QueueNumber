import 'package:auto_route/auto_route.dart';

import 'package:qswait/utils/animation.dart';

import 'app_router.gr.dart';

///route setting
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          initial: true,
          path: '/login',
        ),
        // AutoRoute(
        //   page: MyHomeRoute.page,
        // ),
        // AutoRoute(
        //   page: Customer_page1.page,
        //   path: '/customer',
        //   initial: true,
        // ),

        AutoRoute(
          page: Customer_multiple_category_page.page,
          path: '/customer',
          // initial: true,
        ),
        AutoRoute(
          page: CustomerConfirmRoute.page,
          path: '/customer_confirm',
          // initial: true,
        ),

        AutoRoute(page: NumberInputRoute.page, path: '/number_input'),
        AutoRoute(
            page: AddChildrenNumberRoute.page, path: '/child_number_input'),
        AutoRoute(page: Additional_items.page, path: '/additional_items'),
        AutoRoute(
            page: Additional_category_items.page,
            path: '/additional_category_items'),
        AutoRoute(page: SpcialNote.page, path: '/special_note'),
        AutoRoute(page: FinalCheck.page, path: '/final_check'),

        AutoRoute(page: AdminRoute.page, path: '/admin', children: [
          // AutoRoute(
          //     page: MainSettingRoute.page,
          //     path: 'mainSetting',
          //     initial: true,
          //     allowSnapshotting: false),
          // AutoRoute(
          //     page: QrcodeSettingRoute.page,
          //     path: 'qrcode_setting',
          //     allowSnapshotting: false),
          // AutoRoute(
          //     page: ReceptionItemRoute.page,
          //     path: 'receptionItem',
          //     allowSnapshotting: false),
          // AutoRoute(
          //     page: BasicConfigRoute.page,
          //     path: 'basic_config',
          //     children: [],
          //     allowSnapshotting: false),
          // AutoRoute(
          //     page: WaitingItemTimeSettingRoute.page,
          //     path: 'waitingItemTime',
          //     allowSnapshotting: false),
          // AutoRoute(page: WaitingTime.page, path: 'waitingTime'),
          CustomRoute(
              page: MainSettingRoute.page,
              path: 'mainSetting',
              initial: true,
              // allowSnapshotting: false,
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: QrcodeSettingRoute.page,
              path: 'qrcode_setting',
              // allowSnapshotting: false,
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: ReceptionItemRoute.page,
              path: 'receptionItem',
              // allowSnapshotting: false,
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: BasicConfigRoute.page,
              path: 'basic_config',
              children: [],
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: WaitingItemTimeSettingRoute.page,
              path: 'waitingItemTime',
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: WaitingTime.page,
              path: 'waitingTime',
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          AutoRoute(page: WaitSettingRoute.page, path: 'wait_setting'),
          CustomRoute(
              page: WaitingTimeDisplay.page,
              path: 'waitingTimeDispaly',
              //   customRouteBuilder: customSlidePageRouteBuilder,
              // ),
              transitionsBuilder: fadeSlideTransition),
          CustomRoute(
              page: EditTextRouteRoute.page,
              path: 'editTextRouteRoute',
              transitionsBuilder: fadeSlideTransition),
        ]),
        AutoRoute(page: MerchantMainRoute.page, path: '/merchant'),
        AutoRoute(page: CustomerStopRoute.page, path: '/customer_stop'),
        AutoRoute(
            page: MerchantMultipleMainRoute.page, path: '/multiple_merchant'),
      ];
}
