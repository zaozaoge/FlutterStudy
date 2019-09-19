import 'package:flutter/material.dart';

class GmLocalizations {
  //是否为中文
  bool isZh = false;

  GmLocalizations(this.isZh);

  String get login {
    return isZh ? "登录" : "Login";
  }

  String get noDescription => isZh ? "暂无描述" : "noDescription";

  static GmLocalizations of(BuildContext context) {
    return Localizations.of(context, GmLocalizations);
  }

  String get title {
    return isZh ? "Flutter应用" : "FlutterApp";
  }

  String get home {
    return isZh ? "Github客户端" : "Github Client";
  }
}
