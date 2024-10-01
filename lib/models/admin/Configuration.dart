import 'package:freezed_annotation/freezed_annotation.dart';

part 'Configuration.freezed.dart';
part 'Configuration.g.dart';

@freezed
class Configuration with _$Configuration {
  const factory Configuration({
    required int id,
    required String categoryName,
    required String categoryRange,
    required String queueStatus,
    required int waitTime,
    required int multiGroupWaitTime,
    required bool hasRange,
    required String queueName,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}
