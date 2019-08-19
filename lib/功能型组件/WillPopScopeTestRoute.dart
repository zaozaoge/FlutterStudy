import 'package:flutter/material.dart';


void main(){
  runApp(WillPopScopeTestRoute());
}
class WillPopScopeTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WillPopScopeTestRoute();
  }
}

class _WillPopScopeTestRoute extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: WillPopScope(
            child: Container(
              alignment: Alignment.center,
              child: Text("连续点击退出应用"),
            ),
            onWillPop: () async {
              if (_lastPressedAt == null ||
                  DateTime.now().difference(_lastPressedAt) >
                      Duration(seconds: 1)) {
                _lastPressedAt = DateTime.now();
                return false;
              }
              return true;
            }),
      ),
    );
  }
}
