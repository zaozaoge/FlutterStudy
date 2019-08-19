import 'package:flutter/material.dart';
import 'TurnBox.dart';

void main() => runApp(TurnBoxRoute());

class TurnBoxRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TurnBoxRouteState();
  }
}

class _TurnBoxRouteState extends State<TurnBoxRoute>
    with SingleTickerProviderStateMixin {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("组合控件"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TurnBox(
                child: Icon(
                  Icons.refresh,
                  size: 50.0,
                ),
                speed: 500,
                turns: _turns,
              ),
              TurnBox(
                child: Icon(
                  Icons.refresh,
                  size: 150.0,
                ),
                turns: _turns,
                speed: 1000,
              ),
              RaisedButton(
                  child: Text("顺时针旋转1/5圈"),
                  onPressed: () {
                    setState(() {
                      _turns += .2;
                    });
                  }),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _turns -= .2;
                  });
                },
                child: Text("逆时针旋转1/5圈"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
