import 'package:flutter/material.dart';

void main() {
  runApp(DialogRoute());
}

class DialogRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("DialogRoute"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                bool delete = await showDeleteConfirmDialog(context);
                if (delete == null) {
                  print("取消删除");
                } else {
                  print("确认已删除");
                }
              },
              child: Text("显示对话框"),
            ),
          ],
        )),
      ),
    );
  }

  Future<bool> showDeleteConfirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗？"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("取消")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("删除"))
            ],
          );
        });
  }
}
