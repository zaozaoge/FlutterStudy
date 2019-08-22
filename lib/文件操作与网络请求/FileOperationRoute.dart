import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileOperationRoute extends StatefulWidget {
  FileOperationRoute({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FileOperationRouteState();
  }
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();
  }

  Future<File> _getLocalFile() async {
    //获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File("$dir/counter.txt");
  }

  Future<int> _readCounter() async {
    try {} on FileSystemException {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
