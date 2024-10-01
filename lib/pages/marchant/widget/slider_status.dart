// File: slider_status.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qswait/models/admin/Store_class.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/pages/marchant/style/shop_style.dart';
import 'package:qswait/models/state/callingStatus.dart';
import 'package:qswait/models/state/queueStatus.dart';
import 'package:qswait/pages/marchant/function/function.dart';
import 'package:qswait/services/api/queue_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/utils/Colors.dart';
import 'package:qswait/utils/time.dart';

List<Widget> generateSlidableActions(QueueStatus status, BuildContext context,
    Customer customer, WidgetRef ref) {
  final store = ref.watch(storeProvider);
  bool isExtendedMode = store.maybeWhen(
    data: (data) => data.extendedMode == 'Y',
    orElse: () => false,
  );
  List<Widget> actions = [];
  switch (status) {
    case QueueStatus.Waiting:
      actions = [
        _buildSlidableAction(context, ref, "toCancel", customer,
            AppColors.errorColor, Icons.delete_outline, '取消'),

        _buildSlidableAction(context, ref, "editData", customer,
            AppColors.White, Icons.edit, '更改'),
        _buildSlidableAction(
            context,
            ref,
            "callNumber",
            customer,
            Colors.white,
            Icons.tap_and_play,
            getCallButtonLabel(
                CallingStatusExtension.fromString(customer.callingStatus) ??
                    CallingStatus.notCalled),
            foregroundColor: AppColors.primaryColor), // 更新這一行
        _buildSlidableAction(
            context,
            ref,
            isExtendedMode ? "toProcessing" : "toSeat",
            customer,
            AppColors.primaryColor,
            Icons.airline_seat_recline_extra,
            isExtendedMode ? "處理中" : '入座',
            foregroundColor: AppColors.White),
      ];

      ///先保留
      //  if (isExtendedMode) {
      //   actions.add(_buildSlidableAction(
      //       context, ref, "toFinish", customer, Colors.purple, Icons.done, '完成'));
      // }
      break;
    case QueueStatus.Processing:
      // 根据需要添加其他状态的操作
      actions = [
        _buildSlidableAction(context, ref, "toCancel", customer,
            AppColors.errorColor, Icons.delete_outline, '取消'),

        _buildSlidableAction(
            context,
            ref,
            "callNumber",
            customer,
            Colors.white,
            Icons.tap_and_play,
            getCallButtonLabel(
                CallingStatusExtension.fromString(customer.callingStatus) ??
                    CallingStatus.notCalled),
            foregroundColor: AppColors.primaryColor), // 更新這一行
        _buildSlidableAction(context, ref, "toWaiting", customer,
            AppColors.primaryColor, Icons.event_seat, '回等待',
            foregroundColor: AppColors.White),
      ];
      if (isExtendedMode) {
        actions.add(_buildSlidableAction(context, ref, "toFinish", customer,
            AppColors.primaryColor, Icons.done, '完成',
            foregroundColor: AppColors.White));
      }
      break;
    case QueueStatus.Cancelled:
      actions = [
        // SlidableAction(
        //   spacing: 1,
        //   onPressed: (context) => handleCanceledAction(customer, ref),
        //   backgroundColor: Colors.green,
        //   icon: Icons.event_seat,
        //   label: '回等待中',
        // ),
        _buildSlidableAction(context, ref, "toWaiting", customer,
            AppColors.primaryColor, Icons.event_seat, '回等待',
            foregroundColor: AppColors.White),
      ];
      // 根据需要添加其他状态的操作
      break;
    case QueueStatus.Finished:
      actions = [
        _buildSlidableAction(context, ref, "toCancel", customer,
            AppColors.errorColor, Icons.delete_outline, '取消'),

        _buildSlidableAction(
            context,
            ref,
            "callNumber",
            customer,
            Colors.white,
            Icons.tap_and_play,
            getCallButtonLabel(
                CallingStatusExtension.fromString(customer.callingStatus) ??
                    CallingStatus.notCalled),
            foregroundColor: AppColors.primaryColor), // 更新這一行
        _buildSlidableAction(context, ref, "toWaiting", customer,
            AppColors.primaryColor, Icons.event_seat, '回等待',
            foregroundColor: AppColors.White),
      ];
      if (isExtendedMode) {
        actions.add(
          _buildSlidableAction(context, ref, "toProcessing", customer,
              AppColors.primaryColor, Icons.event_seat, '回處理中',
              foregroundColor: AppColors.White),
        );
      }
      // TODO: Handle this case.
      break;
  }
  return actions;
}

String getCallButtonLabel(CallingStatus status) {
  switch (status) {
    case CallingStatus.notCalled:
      return '叫號';
    case CallingStatus.calling:
      return '再叫號';
    case CallingStatus.alreadyCalled:
      return '再叫號';
    case CallingStatus.callAgain:
      return '再叫號';
    default:
      return '叫號';
  }
}

SlidableAction _buildSlidableAction(BuildContext context, WidgetRef ref,
    String action, Customer customer, Color color, IconData icon, String label,
    {Color? foregroundColor}) {
  return SlidableAction(
      onPressed: (_) => handleChangeStatus(ref, action, customer, context),
      backgroundColor: color,
      icon: icon,
      label: label,
      foregroundColor: foregroundColor);
}

Future<bool> showConfirmationDialog(
    BuildContext context, String message) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('確認'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('確定'),
              ),
            ],
          );
        },
      ) ??
      false;
}

Widget buildCallingStatus(
    Customer customer, BuildContext context, Store? store) {
  var status = CallingStatusExtension.fromString(customer.callingStatus);
  print("customerID: ${customer.id} status: $status");

  // if (store?.showWaitingAlerts == "Y") {
  bool isOverdue(DateTime? callingTime) {
    // if (callingTime == null) return false;

    // final callingDateTime = DateTime.tryParse(callingTime);
    // if (callingDateTime == null) return false;

    final highlightDuration = Duration(minutes: store?.highlightOverTime ?? 0);
    final overdueTime = callingTime?.add(highlightDuration);
    return getCurrentTime().isAfter(overdueTime ?? DateTime.now());
  }
  // }

  switch (status) {
    case CallingStatus.notCalled:
      bool overdue = false;
      if (store?.showWaitingAlerts == "Y" &&
          customer.queueStatus == "waiting") {
        overdue = isOverdue(setUTCPlus8(customer.time));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShopTextSetting.shop_table_calling_text_style("未呼叫",
              color: AppColors.CommonText),
          if (overdue)
            ShopTextSetting.shop_table_calling_text_style(
                "超出 ${store?.highlightOverTime} 分鐘",
                color: AppColors.errorColor)

          ///預留給 超出時間欄位使用
        ],
      );
    case CallingStatus.calling:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopTextSetting.shop_table_calling_text_style("叫號中"),
          ShopTextSetting.shop_table_calling_text_style(
              ' ${convertTimeTo24HourFormat(customer.callingTime ?? "")}')

          // Text('叫號中'),
          // Text(' ${convertTimeTo24HourFormat(customer.callingTime ?? "")}'),
        ],
      );
    case CallingStatus.alreadyCalled:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopTextSetting.shop_table_calling_text_style("已叫號"),
          ShopTextSetting.shop_table_calling_text_style(
              ' ${convertTimeTo24HourFormat(customer.callingTime ?? "")}')
        ],
      );
    case CallingStatus.callAgain:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShopTextSetting.shop_table_calling_text_style("再叫號"),
          ShopTextSetting.shop_table_calling_text_style(
              ' ${convertTimeTo24HourFormat(customer.callingTime ?? "")}')
        ],
      );
    case null:
      return Text('未呼出');
    default:
      return Text('未知狀態');
  }
}
