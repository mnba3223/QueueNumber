enum AdminModeAction {
  numberOfPeople,
  adultsAndChildren,
  autoTakeNumber,
  hideQueue,
  extendedMode,
  skipConfirmationScreen,
  showWaitingAlerts,
  notifyCustomerCancellation,
  useNotepad,
  showGroupsOrPeople,
  useNoCallToCalculate,
  allWaitingTimeDisplayed,
  cuttingInLine,
  stopTakingNumbers,
  frontEndClosed,
  businessHoursTime,
  showWaitingTime,
  notifyTheReceptionist,
  screenSaver
}

extension AdminModeActionExtension on AdminModeAction {
  String get name {
    switch (this) {
      case AdminModeAction.numberOfPeople:
        return 'numberOfPeople';
      case AdminModeAction.adultsAndChildren:
        return 'adultsAndChildren';
      case AdminModeAction.autoTakeNumber:
        return 'autoTakeNumber';
      case AdminModeAction.hideQueue:
        return 'hideQueue';
      case AdminModeAction.extendedMode:
        return 'extendedMode';
      case AdminModeAction.skipConfirmationScreen:
        return 'skipConfirmationScreen';
      case AdminModeAction.showWaitingAlerts:
        return 'showWaitingAlerts';
      case AdminModeAction.notifyCustomerCancellation:
        return 'notifyCustomerCancellation';
      case AdminModeAction.useNotepad:
        return 'useNotepad';
      case AdminModeAction.showGroupsOrPeople:
        return 'showGroupsOrPeople';
      case AdminModeAction.useNoCallToCalculate:
        return 'useNoCallToCalculate';
      case AdminModeAction.allWaitingTimeDisplayed:
        return 'allWaitingTimeDisplayed';
      case AdminModeAction.cuttingInLine:
        return 'cuttingInLine';
      case AdminModeAction.stopTakingNumbers:
        return 'stopTakingNumbers';
      case AdminModeAction.frontEndClosed:
        return 'frontEndClosed';
      case AdminModeAction.businessHoursTime:
        return 'businessHoursTime';
      case AdminModeAction.showWaitingTime:
        return 'showWaitingTime';
      case AdminModeAction.notifyTheReceptionist:
        return 'notifyTheReceptionist';
      case AdminModeAction.screenSaver:
        return 'screenSaver';
    }
  }
}
// class AdminModeSwitchRequest {
//   final int id;
//   final String storeId;
//   final AdminModeAction action;
//   final String modeSwitch;

//   AdminModeSwitchRequest({
//     required this.id,
//     required this.storeId,
//     required this.action,
//     required this.modeSwitch,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'storeId': storeId,
//       'action': action.toString().split('.').last,
//       'modeSwitch': modeSwitch,
//     };
//   }
// }
