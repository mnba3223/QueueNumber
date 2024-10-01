import 'package:flutter/material.dart';
import 'package:qswait/models/User.dart';

class UserService {
  ///註冊者清單

  static bool _loaded = false;

  static String? _accessToken;
  static User? _current;

  // static List<RegisterType> registerList = [];

  //背景自動更新的時間
  static TextEditingController update_time_controller = TextEditingController();

  static String? get accessToken {
    return _accessToken;
  }

  static User? get current {
    return _current;
  }
}
