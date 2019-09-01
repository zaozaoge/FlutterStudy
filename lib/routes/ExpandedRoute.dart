import 'package:flutter/material.dart';

void main() {
  runApp(ExpandedRoute());
}

class ExpandedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ExpandedRoute"),
        ),
        body: Container(
          height: 700.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  height: 60.0,
                  color: Colors.red,
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  height: 80.0,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                          height: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 30.0,
                          color: Colors.yellowAccent,
                        ),
                      )
                    ],
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
