// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/material.dart' as _i25;
import 'package:qswait/models/customer/Customer_class.dart' as _i26;
import 'package:qswait/pages/admin/admin_page.dart' as _i2;
import 'package:qswait/pages/admin/childpage/basic_config.dart' as _i3;
import 'package:qswait/pages/admin/childpage/main_setting.dart' as _i10;
import 'package:qswait/pages/admin/childpage/qrcode_setting_page.dart' as _i15;
import 'package:qswait/pages/admin/childpage/reception_item_page.dart' as _i16;
import 'package:qswait/pages/admin/childpage/waiting_Item_time_setting_page.dart'
    as _i18;
import 'package:qswait/pages/admin/childpage/waiting_time_setting.dart' as _i19;
import 'package:qswait/pages/admin/widgets/edit_text_screen_page.dart' as _i7;
import 'package:qswait/pages/admin/widgets/wait_setting_page.dart' as _i17;
import 'package:qswait/pages/admin/widgets/waiting_time_display.dart' as _i20;
import 'package:qswait/pages/customer/childpage/add_children_number_page.dart'
    as _i1;
import 'package:qswait/pages/customer/childpage/additional_category_items.dart'
    as _i21;
import 'package:qswait/pages/customer/childpage/additional_items.dart' as _i22;
import 'package:qswait/pages/customer/childpage/customer_confirm_page.dart'
    as _i4;
import 'package:qswait/pages/customer/childpage/final_check.dart' as _i8;
import 'package:qswait/pages/customer/childpage/notePad.dart' as _i13;
import 'package:qswait/pages/customer/childpage/Number_input_page.dart' as _i14;
import 'package:qswait/pages/customer/childpage/special_note.dart' as _i23;
import 'package:qswait/pages/customer/customer_multiple_category_page.dart'
    as _i6;
import 'package:qswait/pages/customer/customer_stop_page.dart' as _i5;
import 'package:qswait/pages/login/login_page.dart' as _i9;
import 'package:qswait/pages/marchant/merchant_main.dart' as _i11;
import 'package:qswait/pages/marchant/merchant_multiple_main.dart' as _i12;

abstract class $AppRouter extends _i24.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    AddChildrenNumberRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddChildrenNumberPage(),
      );
    },
    AdminRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AdminPage(),
      );
    },
    BasicConfigRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.BasicConfigPage(),
      );
    },
    CustomerConfirmRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CustomerConfirmPage(),
      );
    },
    CustomerStopRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CustomerStopPage(),
      );
    },
    Customer_multiple_category_page.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.Customer_multiple_category_page(),
      );
    },
    EditTextRouteRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EditTextScreenPage(),
      );
    },
    FinalCheck.name: (routeData) {
      final args = routeData.argsAs<FinalCheckArgs>(
          orElse: () => const FinalCheckArgs());
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.FinalCheck(
          key: args.key,
          customer: args.customer,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.LoginPage(),
      );
    },
    MainSettingRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.MainSettingPage(),
      );
    },
    MerchantMainRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MerchantMainPage(),
      );
    },
    MerchantMultipleMainRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MerchantMultipleMainPage(),
      );
    },
    NotePadRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.NotePadPage(),
      );
    },
    NumberInputRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.NumberInputPage(),
      );
    },
    QrcodeSettingRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.QrcodeSettingPage(),
      );
    },
    ReceptionItemRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.ReceptionItemPage(),
      );
    },
    WaitSettingRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.WaitSettingPage(),
      );
    },
    WaitingItemTimeSettingRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.WaitingItemTimeSettingPage(),
      );
    },
    WaitingTime.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.WaitingTime(),
      );
    },
    WaitingTimeDisplay.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.WaitingTimeDisplay(),
      );
    },
    Additional_category_items.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.additional_category_items(),
      );
    },
    Additional_items.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.additional_items(),
      );
    },
    SpcialNote.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.spcialNote(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddChildrenNumberPage]
class AddChildrenNumberRoute extends _i24.PageRouteInfo<void> {
  const AddChildrenNumberRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AddChildrenNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddChildrenNumberRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AdminPage]
class AdminRoute extends _i24.PageRouteInfo<void> {
  const AdminRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BasicConfigPage]
class BasicConfigRoute extends _i24.PageRouteInfo<void> {
  const BasicConfigRoute({List<_i24.PageRouteInfo>? children})
      : super(
          BasicConfigRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasicConfigRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CustomerConfirmPage]
class CustomerConfirmRoute extends _i24.PageRouteInfo<void> {
  const CustomerConfirmRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CustomerConfirmRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerConfirmRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CustomerStopPage]
class CustomerStopRoute extends _i24.PageRouteInfo<void> {
  const CustomerStopRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CustomerStopRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerStopRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i6.Customer_multiple_category_page]
class Customer_multiple_category_page extends _i24.PageRouteInfo<void> {
  const Customer_multiple_category_page({List<_i24.PageRouteInfo>? children})
      : super(
          Customer_multiple_category_page.name,
          initialChildren: children,
        );

  static const String name = 'Customer_multiple_category_page';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EditTextScreenPage]
class EditTextRouteRoute extends _i24.PageRouteInfo<void> {
  const EditTextRouteRoute({List<_i24.PageRouteInfo>? children})
      : super(
          EditTextRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditTextRouteRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i8.FinalCheck]
class FinalCheck extends _i24.PageRouteInfo<FinalCheckArgs> {
  FinalCheck({
    _i25.Key? key,
    _i26.Customer? customer,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          FinalCheck.name,
          args: FinalCheckArgs(
            key: key,
            customer: customer,
          ),
          initialChildren: children,
        );

  static const String name = 'FinalCheck';

  static const _i24.PageInfo<FinalCheckArgs> page =
      _i24.PageInfo<FinalCheckArgs>(name);
}

class FinalCheckArgs {
  const FinalCheckArgs({
    this.key,
    this.customer,
  });

  final _i25.Key? key;

  final _i26.Customer? customer;

  @override
  String toString() {
    return 'FinalCheckArgs{key: $key, customer: $customer}';
  }
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i24.PageRouteInfo<void> {
  const LoginRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MainSettingPage]
class MainSettingRoute extends _i24.PageRouteInfo<void> {
  const MainSettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          MainSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainSettingRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MerchantMainPage]
class MerchantMainRoute extends _i24.PageRouteInfo<void> {
  const MerchantMainRoute({List<_i24.PageRouteInfo>? children})
      : super(
          MerchantMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MerchantMainRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MerchantMultipleMainPage]
class MerchantMultipleMainRoute extends _i24.PageRouteInfo<void> {
  const MerchantMultipleMainRoute({List<_i24.PageRouteInfo>? children})
      : super(
          MerchantMultipleMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MerchantMultipleMainRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NotePadPage]
class NotePadRoute extends _i24.PageRouteInfo<void> {
  const NotePadRoute({List<_i24.PageRouteInfo>? children})
      : super(
          NotePadRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotePadRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i14.NumberInputPage]
class NumberInputRoute extends _i24.PageRouteInfo<void> {
  const NumberInputRoute({List<_i24.PageRouteInfo>? children})
      : super(
          NumberInputRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumberInputRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i15.QrcodeSettingPage]
class QrcodeSettingRoute extends _i24.PageRouteInfo<void> {
  const QrcodeSettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          QrcodeSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrcodeSettingRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i16.ReceptionItemPage]
class ReceptionItemRoute extends _i24.PageRouteInfo<void> {
  const ReceptionItemRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ReceptionItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReceptionItemRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i17.WaitSettingPage]
class WaitSettingRoute extends _i24.PageRouteInfo<void> {
  const WaitSettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          WaitSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitSettingRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i18.WaitingItemTimeSettingPage]
class WaitingItemTimeSettingRoute extends _i24.PageRouteInfo<void> {
  const WaitingItemTimeSettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          WaitingItemTimeSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitingItemTimeSettingRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i19.WaitingTime]
class WaitingTime extends _i24.PageRouteInfo<void> {
  const WaitingTime({List<_i24.PageRouteInfo>? children})
      : super(
          WaitingTime.name,
          initialChildren: children,
        );

  static const String name = 'WaitingTime';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i20.WaitingTimeDisplay]
class WaitingTimeDisplay extends _i24.PageRouteInfo<void> {
  const WaitingTimeDisplay({List<_i24.PageRouteInfo>? children})
      : super(
          WaitingTimeDisplay.name,
          initialChildren: children,
        );

  static const String name = 'WaitingTimeDisplay';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i21.additional_category_items]
class Additional_category_items extends _i24.PageRouteInfo<void> {
  const Additional_category_items({List<_i24.PageRouteInfo>? children})
      : super(
          Additional_category_items.name,
          initialChildren: children,
        );

  static const String name = 'Additional_category_items';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i22.additional_items]
class Additional_items extends _i24.PageRouteInfo<void> {
  const Additional_items({List<_i24.PageRouteInfo>? children})
      : super(
          Additional_items.name,
          initialChildren: children,
        );

  static const String name = 'Additional_items';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i23.spcialNote]
class SpcialNote extends _i24.PageRouteInfo<void> {
  const SpcialNote({List<_i24.PageRouteInfo>? children})
      : super(
          SpcialNote.name,
          initialChildren: children,
        );

  static const String name = 'SpcialNote';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}
