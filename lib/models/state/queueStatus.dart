import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum QueueStatus { Waiting, Cancelled, Processing, Finished }

extension QueueStatusExtension on QueueStatus {
  String toShortString() {
    return toString().split('.').last.toLowerCase();
  }

  String localized(BuildContext context) {
    return context.tr(toShortString());
  }

  static QueueStatus? fromString(String statusString) {
    switch (statusString) {
      case 'waiting':
        return QueueStatus.Waiting;
      case 'cancelled':
        return QueueStatus.Cancelled;
      case 'processing':
        return QueueStatus.Processing;
      case 'seating':
        return QueueStatus.Finished;
      // case 'seating':
      //   return QueueStatus.Seating;
      case 'finished':
        return QueueStatus.Finished;
      default:
        return null; // unexpected
    }
  }
}
