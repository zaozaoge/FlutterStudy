import 'package:flutter/material.dart';
import 'GradientButton.dart';

void main() {
  runApp(GradientButtonRoute());
}

class GradientButtonRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradientButtonRouteState();
  }
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("GradientButtonRoute"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GradientButton(
                  child: Text('Submit'),
                  colors: [Colors.orange, Colors.green],
                  height: 50.0,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  onPressed: onTap,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GradientButton(
                  child: Text('Submit1'),
                  colors: [Colors.cyan[100], Colors.green, Colors.amberAccent],
                  height: 50.0,
                  onPressed: onTap,
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onTap() {
    print('button click');
  }
}
