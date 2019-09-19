import 'package:flutter/material.dart';
import 'package:flutter_app/common/ProfileChangeNotifier.dart';
import 'package:flutter_app/i10n/GmLocalizations.dart';
import 'package:flutter_app/routes/HomeRoute.dart';
import 'package:flutter_app/states/LanguageRoute.dart';
import 'package:flutter_app/states/LoginRoute.dart';
import 'package:flutter_app/states/ThemeChangeRoute.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel())
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder:
          (BuildContext context, themeModel, localModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: themeModel.theme),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: HomeRoute(),
          locale: localModel.getLocale(),
          //只支持美式英语和中文简体
          supportedLocales: [
            const Locale('en', 'US'), //美式英语
            const Locale('zh', 'CN'), //简体中文
          ],
          //注册命名路由表
          routes: <String, WidgetBuilder>{
            "login": (context) => LoginRoute(),
            "theme": (context) => ThemeChangeRoute(),
            "language": (context) => LanguageRoute()
          },
        );
      }),
    );
  }
}
