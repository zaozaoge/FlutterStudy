import 'package:flutter/material.dart';
import 'package:flutter_app/common/Global.dart';
import 'package:flutter_app/states/MyApp.dart';

void main() {
  Global.init().then((e)=>runApp(MyApp()));
}
