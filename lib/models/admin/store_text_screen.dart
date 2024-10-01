import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qswait/services/api/admin_api.dart';

part 'store_text_screen.freezed.dart';
part 'store_text_screen.g.dart';

@freezed
// class StoreTextScreenRequest with _$StoreTextScreenRequest {
//   factory StoreTextScreenRequest({
//     required String storeId,
//     required String noOneQueuing,
//     required String someOneQueuing,
//     required String stopTakeNumber,
//     required String limitTakeNumber,
//   }) = _StoreTextScreenRequest;

//   factory StoreTextScreenRequest.fromJson(Map<String, dynamic> json) =>
//       _$StoreTextScreenRequestFromJson(json);
// }

@freezed
class StoreTextScreenResponse with _$StoreTextScreenResponse {
  factory StoreTextScreenResponse({
    required int id,
    required String storeId,
    required String noOneQueuing,
    required String someOneQueuing,
    required String stopTakeNumber,
    required String limitTakeNumber,
  }) = _StoreTextScreenResponse;

  factory StoreTextScreenResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreTextScreenResponseFromJson(json);
}

class StoreTextScreenNotifier
    extends StateNotifier<AsyncValue<StoreTextScreenResponse>> {
  StoreTextScreenNotifier() : super(const AsyncLoading());

  Future<void> fetchStoreTextScreen(String storeId) async {
    try {
      final response = await getStoreTextScreen(storeId);
      if (response.success) {
        state = AsyncData(response.data!);
      } else {
        state = AsyncError(response.message, StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
      print('Error fetching store text screen: $e');
    }
  }

  Future<void> updateStoreTextScreenbyAPi(
      StoreTextScreenResponse request) async {
    try {
      final response = await updateStoreTextScreen(request);
      if (response.success) {
        state = AsyncData(request);
      } else {
        state = AsyncError(response.message, StackTrace.current);
      }
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
      print('Error updating store text screen: $e');
    }
  }
}
