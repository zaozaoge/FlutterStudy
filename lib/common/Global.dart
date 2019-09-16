import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile.dart';
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global{
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  //网络缓存对象
 // static NetCache netCache = NetCache();
  //可选的主题列表
  static List<MaterialColor> get themes => _themes;
}