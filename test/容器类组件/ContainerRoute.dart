import 'package:flutter/material.dart';

void main() {
  runApp(ContainerRoute());
}

class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ContainerRoute"),
        ),
        body: Center(
          child: Container(
            child: Text(
              "曾经有一份真诚的爱情摆在我的面前，但我没有珍惜",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.wavy),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            alignment: Alignment.center,
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.blue)),
          ),
        ),
      ),
    );
  }
}
