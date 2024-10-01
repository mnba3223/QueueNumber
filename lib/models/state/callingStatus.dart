import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum CallingStatus { notCalled, calling, alreadyCalled, callAgain }

extension CallingStatusExtension on CallingStatus {
  String toShortString() {
    return toString().split('.').last;
  }

  String localized(BuildContext context) {
    // 確保你有定義對應的本地化方法
    return context.tr(toShortString().toLowerCase());
  }

  static CallingStatus? fromString(String? statusString) {
    switch (statusString) {
      case 'notCalled':
        return CallingStatus.notCalled;
      case 'calling':
        return CallingStatus.calling;
      case 'alreadyCalled':
        return CallingStatus.alreadyCalled;
      case 'callAgain':
        return CallingStatus.callAgain;
      default:
        return null; // unexpected
    }
  }
}

String callingStatusLocalized(BuildContext context, String text) {
  // 確保你有定義對應的本地化方法
  return context.tr(text);
}
