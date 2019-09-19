import 'package:flutter/material.dart';
import 'package:flutter_app/common/Global.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/models/profile.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    //保存Profile
    Global.saveProfile();
    //通知依赖的Widget更新
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  //app是否登陆过（如果有用户信息，则登录过）
  bool get isLogin => user != null;

  //用户信息变化时，更新用户信息并通知依赖他的子Widget更新
  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  //获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((e) => e.value == _profile.theme, orElse: () => Colors.blue);

  //主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch colorSwatch) {
    if (colorSwatch != theme) {
      _profile.theme = colorSwatch[500].value;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  //获取当前用户的App语言配置，如果为null,则语言跟随系统语言
  Locale getLocale() {
    if (_profile.local == null) return null;
    var t = _profile.local.split("_");
    return Locale(t[0], t[1]);
  }

  //获取当前Locale的字符串表示
  String get local => _profile.local;

  //用户更改app语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.local) {
      _profile.local = locale;
      notifyListeners();
    }
  }
}
