import 'package:flutter/material.dart';

class GmLocalizations {
  //是否为中文
  bool isZh = false;

  GmLocalizations(this.isZh);

  String get login {
    return isZh ? "登录" : "Login";
  }

  String get noDescription => isZh ? "暂无描述" : "noDescription";

  String get userName => isZh ? "用户名" : "userName";

  get userNameOrEmail => isZh ? "用户名或邮箱" : "userNameOrEmail";

  get userNameRequired => isZh ? "用户名不能为空" : "userNameRequired";

  get password => isZh ? "密码" : "password";

  get passwordRequired => isZh ? "密码不能为空" : "passwordRequired";

  static GmLocalizations of(BuildContext context) {
    if (null == Localizations.of(context, GmLocalizations)) {
      print("GmLocalizations is null");
    }
    return Localizations.of(context, GmLocalizations);
  }

  String get title {
    return isZh ? "Flutter应用" : "FlutterApp";
  }

  String get home {
    return isZh ? "Github客户端" : "Github Client";
  }
}
