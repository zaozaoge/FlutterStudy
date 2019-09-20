import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }

}

class _HomeRouteState extends State<HomeRoute>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Github"),),);
  }

}
