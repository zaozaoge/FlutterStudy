import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
void main() {
  runApp(DioTestRoute());
}

class DioTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DioTestRouteState();
  }
}

class _DioTestRouteState extends State<DioTestRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("DioTestRoute"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder(
              future:
                  _dio.get("https://api.github.com/orgs/flutterchina/repos"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //请求完成
                if (snapshot.connectionState == ConnectionState.done) {
                  Response response = snapshot.data;
                  //发生错误
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  //请求成功，通过项目信息构建用于显示项目名称的ListView
                  LogUtil.init(isDebug: true,tag: "Dio");
                  LogUtil.v(response.data.toString());
                  return ListView(
                    children: response.data.map<Widget>((e) =>
                        ListTile(title: Text(e["full_name"]))
                    ).toList(),
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
