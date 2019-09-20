import 'package:flutter/material.dart';
import 'package:flutter_app/common/Git.dart';
import 'package:flutter_app/common/Global.dart';
import 'package:flutter_app/common/ProfileChangeNotifier.dart';
import 'package:flutter_app/i10n/GmLocalizations.dart';
import 'package:flutter_app/models/index.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否明文显示
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    //自动填充上次登录的用户名，填充后将焦点定位到密码框
    _userNameController.text = Global.profile.lastLogin;
    if (_userNameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _userNameController,
                decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userNameOrEmail,
                    prefixIcon: Icon(Icons.person)),
                validator: (v) {
                  return v.trim().isNotEmpty ? null : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: gm.password,
                    hintText: gm.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                            pwdShow ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            pwdShow = !pwdShow;
                          });
                        })),
                obscureText: !pwdShow,
                validator: (v) {
                  return v.trim().isNotEmpty ? null : gm.passwordRequired;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    onPressed: _onLogin,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(gm.login),
                  ),
                ),
              ),
            ],
          ),
          autovalidate: true,
        ),
      ),
    );
  }

  void _onLogin() async {
    //提交前先验证各个表单的字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      User user;
      try {
        user = await Git(context)
            .login(_userNameController.text, _pwdController.text);
        //因为登录页返回后，首页会build,所以我们传false,更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        if (e.response?.statusCode == 401) {
          print("用户名或密码错误");
        } else {
          print(e.toString());
        }
      } finally {
       // Navigator.of(context).pop();
      }
      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
