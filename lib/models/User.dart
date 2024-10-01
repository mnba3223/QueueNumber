import 'package:freezed_annotation/freezed_annotation.dart';

part 'User.freezed.dart';
part 'User.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int userid,
    required String username,
    String? password,
    // String? usernickname,
    int? type,
    String? department,
    String? fullname,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
