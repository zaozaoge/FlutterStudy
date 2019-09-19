import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/Git.dart';
import 'package:flutter_app/common/ProfileChangeNotifier.dart';
import 'package:flutter_app/i10n/GmLocalizations.dart';
import 'package:flutter_app/models/index.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      //用户未登陆，显示登陆按钮
      return Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text(GmLocalizations.of(context).login),
        ),
      );
    } else {
      //已登录，显示项目列表
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          var data = await Git(context).getRepos(
              refresh: refresh, queryParams: {'page': page, 'page_size': 20});
          //将请求到的数据添加到items中
          items.addAll(data);
          //如果接口返回的数据等于page_size,则认为还有数据，反之则认为最后一项
          return data.length == 20;
        },
        itemBuilder: (List list, int index, BuildContext buildContext) {},
      );
    }
  }
}
