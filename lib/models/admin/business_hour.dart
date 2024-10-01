import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessHour {
  final String startTime;
  final String endTime;

  BusinessHour({required this.startTime, required this.endTime});

  factory BusinessHour.fromJson(Map<String, dynamic> json) {
    return BusinessHour(
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}

class StoreReceptionHoursRequest {
  final String storeId;
  // final String operation;
  final List<BusinessHour> businessHours;

  StoreReceptionHoursRequest({
    required this.storeId,
    // required this.operation,
    required this.businessHours,
  });

  factory StoreReceptionHoursRequest.fromJson(Map<String, dynamic> json) {
    return StoreReceptionHoursRequest(
      storeId: json['storeId'],
      // operation: json['operation'],
      businessHours: (json['businessHours'] as List)
          .map((e) => BusinessHour.fromJson(e))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      // 'operation': operation,
      'businessHours': businessHours.map((e) => e.toJson()).toList(),
    };
  }
}

class BusinessHoursNotifier extends StateNotifier<List<BusinessHour>> {
  BusinessHoursNotifier() : super([]);

  void updateBusinessHours(List<BusinessHour> hours) {
    state = hours;
  }
}
