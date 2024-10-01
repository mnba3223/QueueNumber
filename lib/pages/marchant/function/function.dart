import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qswait/models/customer/Customer_class.dart';
import 'package:qswait/models/response/api_response.dart';
import 'package:qswait/models/state/queueStatus.dart';
import 'package:qswait/pages/marchant/widget/customer_edit_dialog.dart';
import 'package:qswait/pages/marchant/widget/slider_status.dart';
import 'package:qswait/services/api/queue_api.dart';
import 'package:qswait/services/riverpod_state_management.dart';
import 'package:qswait/widgets/dialog.dart';

/// 處理Waiting排隊狀態
Future<void> handleChangeStatus(WidgetRef ref, String status, Customer customer,
    BuildContext context) async {
  ///確認修改狀態
  QueueStatus changeState;
  String dialogMessage = '';
  String numberStatus = ''; // 新增這個變數來處理 `toWaiting` 狀態的附加資訊
  showLoadingDialog(context); // 顯示處理中對話框
  try {
    switch (status) {
      case "toCancel":
        changeState = QueueStatus.Cancelled;
        dialogMessage = '您確定要取消這個顧客的排隊嗎？';
        await _handleQueueChangeStatus(
            ref, customer, context, changeState, dialogMessage);
        break;
      case "editData":
        await showEditCustomerDialog(context, ref, customer: customer);
        // hideLoadingDialog(context); // 隱藏處理中對話框
        break;
      case "toSeat":
        changeState = QueueStatus.Finished;
        dialogMessage = '您確定要將這個顧客更改為入座狀態嗎？';
        await _handleQueueChangeStatus(
            ref, customer, context, changeState, dialogMessage);
        break;
      case "toProcessing":
        changeState = QueueStatus.Processing;
        dialogMessage = '您確定要將這個顧客更改為處理中狀態嗎？';
        await _handleQueueChangeStatus(
            ref, customer, context, changeState, dialogMessage);
        break;
      case "toWaiting":
        changeState = QueueStatus.Waiting;
        numberStatus = await showPositionDialog(context);
        if (numberStatus != "") {
          await _handleQueueChangeStatus(
              ref, customer, context, changeState, '',
              numberStatus: numberStatus);
        }
        break;
      case "toFinish":
        changeState = QueueStatus.Finished;
        dialogMessage = '您確定要將這個顧客更改為完成狀態嗎？';
        await _handleQueueChangeStatus(
            ref, customer, context, changeState, dialogMessage);
        break;
      case "callNumber":
        ApiResponse<Customer> response = await callNumber(customer.id);
        if (response.success && response.data != null) {
          ref
              .read(customerQueueProvider.notifier)
              .updateCustomer(response.data!);
        } else {
          showError(context, '取號失敗：${response.message}');
        }
        break;

      default:
        showError(context, '未知的操作');
        return;
    }
  } finally {
    hideLoadingDialog(context); // 隱藏處理中對話框
  }

  /// 等待回傳修改狀態後API
  /// 修改 customer 的排隊狀態，最好是修改riverpod 的狀態
  // ref.read(customerQueueProvider.notifier).updateCustomer(customer);
  // ref.read(customerQueueProvider.notifier).fetchCustomersFromApi(ref);
}

/// 處理狀態變更的輔助函數
Future<void> _handleQueueChangeStatus(WidgetRef ref, Customer customer,
    BuildContext context, QueueStatus changeState, String dialogMessage,
    {String numberStatus = ""}) async {
  bool confirmed = true;

  if (dialogMessage.isNotEmpty) {
    confirmed = await showConfirmationDialog(context, dialogMessage);
  }

  if (confirmed) {
    ApiResponse<void> response = await changeQueueStatus(
        customer.id, changeState.toShortString(),
        numbmerStatus: numberStatus);
    if (response.success) {
      ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
    } else {
      showError(context, '更新失敗：${response.message}');
    }
  }
}

/// 處理Waiting呼叫狀態
void handleWaitingCall(WidgetRef ref, String status, Customer customer) {
  /// send call api
  ///  確認修改狀態
  ///確認修改狀態

  /// 等待回傳修改後的API
  ///  修改 customer 的 呼叫狀態跟時間，最好是修改riverpod 的狀態
  // ref.read(customerQueueProvider.notifier).updateCustomer(customer);
  // ref.read(customerQueueProvider.notifier).fetchCustomersFromApi(ref);
}

///處理Seating 叫號
void handleSeatingCall(WidgetRef ref, String status, Customer customer) {
  /// send call api
  ///  確認修改狀態
  ///確認修改狀態
  /// 等待回傳修改後的API
  ///  修改 customer 的 呼叫狀態跟時間，最好是修改riverpod 的狀態
  // ref.read(customerQueueProvider.notifier).updateCustomer(customer);
  ref.read(customerQueueProvider.notifier).fetchCustomersFromApi();
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

double getQueueStatusNumber(QueueStatus queueStatus) {
  switch (queueStatus) {
    case QueueStatus.Waiting:
      return 0.7;
    case QueueStatus.Processing:
      return 0.7;
    case QueueStatus.Cancelled:
      return 0.2;
    case QueueStatus.Finished:
      return 0.7;
    default:
      return 0.6;
  }
}

/// 顯示位置選擇對話框
Future<String> showPositionDialog(BuildContext context) async {
  return await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('選擇位置'),
            content: Text('您要將這個顧客更改為回到原本位置還是最後的位置？'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop("");
                },
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop("original");
                },
                child: Text('原本位置'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop("last");
                },
                child: Text('最後位置'),
              ),
            ],
          );
        },
      ) ??
      "";
}
